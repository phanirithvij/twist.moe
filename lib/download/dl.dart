import 'dart:io';

import 'package:twist_moe/download/down.dart' show download;
import 'package:path/path.dart' as p;

Future<void> downloadFromList(
  List<String> urls,
  String format,
  int start,
  int end,
  int numeps,
  String name,
  String dir,
) async {
  if (end == 0) {
    end = urls.length;
  }
  if (numeps != 0) {
    end = numeps + start - 1;
  } else {
    numeps = end - start + 1;
  }

  print("Downloading $numeps episodes");
  final List<List<Object>> dlUrlsIndex = [];
  for (int i = 0; i < urls.length; i++) {
    final url = urls[i];
    if (i + 1 <= end && i + 1 >= start) {
      // print(url);
      dlUrlsIndex.add([i, url]);
    }
  }

  void doit(List<Object> s) async {
    final int i = s[0];
    final String url = s[1];
    final paddedNum =
        (i + 1).toString().padLeft(urls.length.toString().length, '0');
    var filename = format
        .replaceAll(':number', "${i + 1}")
        .replaceAll(':name', name)
        .replaceAll(':Pnumber', paddedNum);
    filename += '.mp4';
    final fileSavePath = p.join(dir, filename);

    print("Downloading $url to $fileSavePath");
    await download(url, fileSavePath);
  }

  Future.forEach(dlUrlsIndex, doit);
}

Future<void> downloadFromFile(
  String path,
  String name,
  String format, {
  int start: 0,
  int end: 0,
  int numeps: 0,
  String dir: 'Anime',
}) async {
  if (!File(path).existsSync()) {
    print('no such file $path');
    return;
  }
  var lines = await File(path).readAsLines();
  print("Got lines");
  await downloadFromList(lines, format, start, end, numeps, name, dir);
}

void main(List<String> args) {
  if (args.length < 1) {
    print('Usage: pass a file as an argument');
    return;
  }
  final filename = args[0];
  final start = 1;
  final end = 1;
  final numeps = 0;
  downloadFromFile(
    filename,
    'one-punch-man',
    ':name-:number',
    start: start,
    end: end,
    numeps: numeps,
  );
}
