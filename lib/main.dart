import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:twist_moe/args.dart';
import 'package:twist_moe/decrypt.dart';
import 'package:twist_moe/download/dl.dart';

import 'api.dart' as api;

void main(List<String> args) async {
  final parser = buildParser();
  argResults = parser.parse(args);

  if (argResults['help']) {
    // Show help and exit
    print(parser.usage);
    return;
  }

  // TODO: Validate args

  final String inputFile = argResults['if'];
  final String givenName = argResults['name'];
  final String format = argResults['format'];
  final start = int.tryParse(argResults['start'] ?? '0') ?? 0;
  final end = int.tryParse(argResults['end'] ?? '0') ?? 0;
  final numeps = int.tryParse(argResults['count'] ?? '0') ?? 0;
  String animeDir = argResults['dir'];

  if (end != 0 && end < start) {
    print('End is less than Start');
    return;
  }

  if (end != 0 && numeps != 0 && end != null && numeps != null) {
    // Both were specified
    print("End and Number of eps cannot be specified together");
    return;
  }

  animeDir = p.normalize(animeDir);
  final dir = Directory(animeDir);

  if (!dir.existsSync()) {
    print("Creating $animeDir directory..");
    dir.createSync(recursive: true);
  }

  if (argResults['if'] != null) {
    // download from file
    var destDir = animeDir;
    if (animeDir == 'Anime') {
      destDir = p.join(animeDir, givenName);
    }
    await downloadFromFile(inputFile, givenName, format,
        start: start, end: end, numeps: numeps, dir: destDir);
    return;
  }

  List<String> urls = [];

  if (argResults.rest.length < 1) {
    print("Enter link from https://twist.moe/");
    final input = stdin.readLineSync().trim();
    urls.addAll(input.split(RegExp(r"(,| )")));
  } else {
    urls.addAll(argResults.rest.join(" ").split(RegExp(r"(,| )")));
  }
  // remove empty entries
  urls.retainWhere((str) => str.trim() != "");
  final urlList = urls.map((url) => processUrl(url, dir, givenName)).toList();
  if (urls.length > 1 && argResults['download']) {
    // Multiple urls were specified
    // Better not download
    print("Multiple urls were specified");
    print(
        "Start, End etc.. will not be ignored but the same values will be used for all the anime");
    print("Do you want to proceed?(y/n)");

    final response = stdin.readLineSync().trim();
    final yes = response.contains(RegExp('(yes)|(y)|(ok)|(yep)'));
    if (!yes) {
      print("You said $response");
      return;
    }
  }
  for (int i = 0; i < urlList.length; i++) {
    final f = urlList[i];
    final curls = await f;
    print("curls $i");
    if (argResults['download']) {
      // If no name was given use the one from the url
      var destDir = animeDir;
      if (animeDir == 'Anime') {
        destDir = p.join(animeDir, curls['name']);
      }
      await downloadFromList(List.from(curls['urls']), format, start, end,
          numeps, givenName ?? curls['name'], destDir);
    } else {
      print("""
      To download this anime use:
        twist.exe -i ${curls['listPath']} -n ${curls['name']}
      """
          .trim());
    }
  }
}

ArgResults argResults;

Future<Map> processUrl(String url, Directory animeDir, String givenName) async {
  var animeName = "";
  var animeUrl = url;
  if (url.startsWith("https://twist.moe/a/")) {
    animeName = url.split("/")[4].trim();
    animeUrl = url.split("/").sublist(0, 5).join("/") + "/1";
  } else {
    animeName = url.trim();
    animeUrl = "https://twist.moe/a/$animeName/1";
  }
  print("Url: $animeUrl");

  final animeDirectory =
      Directory(p.join(animeDir.path, givenName ?? animeName));
  if (!animeDirectory.existsSync()) {
    print('Creating ${animeDirectory.path} directory...');
    animeDirectory.createSync(recursive: true);
  }

  /// if given name is null then use [animeName]
  final listFile = File(p.join(animeDirectory.path, "list.txt"));
  if (listFile.existsSync()) {
    listFile.deleteSync();
  }

  try {
    final episodes = await api.getUrls(animeName);
    // get the encrypted urls
    final encUrls = episodes.map((e) => e.source);
    final decUrls = decryptUrls(encUrls);
    // Got the urls
    if (decUrls == null || decUrls.length == 0) {
      print(
          "Couldn't fetch the urls for $animeUrl please check if the url you've provided is correct");
      return {};
    }
    // https://stackoverflow.com/a/17407240/8608146
    final urls = decUrls.map((f) => Uri.encodeFull("https://twist.moe$f"));
    print("Got ${urls.length} url${urls.length == 1 ? "" : "s"}");
    print("Wrote urls to ${listFile.path}");
    listFile.create().then((f) {
      f.writeAsString(urls.join('\n') + "\n").catchError((e) {
        print(e);
      }).whenComplete(() {});
      // Must not exit here because there might be multiple urls in args
    });
    return {"urls": urls, "name": animeName, "listPath": listFile.path};
    // Write this to a file
  } on SocketException catch (e) {
    print("Network error $e");
    return {};
  }
}
