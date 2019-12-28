import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/args.dart';
import 'package:twist_moe/decrypt.dart';
import 'api.dart' as api;

ArgResults argResults;

void main(List<String> args) {
  final parser = ArgParser();
  argResults = parser.parse(args);

  var animeDir = "Anime";
  animeDir = p.normalize(animeDir);
  var dir = Directory(animeDir);

  if (!dir.existsSync()) {
    print("Creating Anime directory..");
    dir.createSync();
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
  urls.forEach((url) => processUrl(url));
}

void processUrl(String url) async {
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
  final animeDir = Directory("Anime/$animeName");
  if (!animeDir.existsSync()) {
    print("Creating $animeDir directory..");
    animeDir.createSync();
  }
  final listFile = File("${animeDir.path}/list.txt");
  if (listFile.existsSync()) {
    listFile.deleteSync();
  }

  print("Fetching info...");
  try {
    final episodes = await api.getUrls(animeName);
    // get the encrypted urls
    final encUrls = episodes.map((e) => e.source);
    final decUrls = decryptUrls(encUrls);
    // Got the urls
    assert(decUrls != null);
    assert(decUrls.length != 0);
    final urls = decUrls.map((f) => Uri.encodeFull("https://twist.moe$f"));
    print("Got ${urls.length} url${urls.length == 1 ? "" : "s"}");
    print("Wrote urls to ${listFile.path}");
    listFile.create().then((f) {
      f.writeAsString(urls.join('\n')).catchError((e) {
        print(e);
      }).whenComplete(() {
        print("Done");
        exit(0);
      });
    });
    // Write this to a file
  } on SocketException catch (e) {
    print("Network error $e");
  }
}
