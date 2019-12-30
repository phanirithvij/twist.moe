import 'dart:async';

import 'package:path/path.dart' as _path;
import 'package:semaphore/semaphore.dart';
import 'package:twist_moe/download/down.dart';

Future<void> main() async {
  final maxCount = 1;
  final s = LocalSemaphore(maxCount);
  _getUrl().forEach((uri) async {
    try {
      await s.acquire();
      var path = _path.basename(_path.dirname(uri.toString()));
      path += '.js';
      path = "temp/temp/$path";
      await download(uri.toString(), path);
    } finally {
      s.release();
    }
  });
}

// Future<void> download(String url, String path) async {
//   print('Start download: $url');
//   var downloadSize = 0;
//   final completer = Completer<void>();
//   final client = HttpClient();
//   final request = await client.getUrl(Uri.parse(url));
//   final resp = await request.close();
//   downloadSize = resp.contentLength;
//   final file = File(path).openWrite(mode: FileMode.writeOnlyAppend);
//   final bar = ProgressBar(
//     ":percent [:bar] :Hcurrent/:Htotal ETA :etas",
//     total: downloadSize,
//   );
//   resp.listen((data) {
//     file.add(data);
//     // show progress bar
//     if (downloadSize > 0) bar.tick(len: data.length);
//   }, onError: (e) {
//     completer.completeError(e);
//   }, onDone: () {
//     file.close().then((e) {
//       print('Downloaded: $url');
//       print('File written: $path');
//       completer.complete();
//     });
//   });

//   return completer.future;
// }

void report(String url, [String file = '']) {
  print('${DateTime.now()}: $url');
  if (file.isNotEmpty) {
    print('File: $file');
  }
}

List<String> _versions = [
  '5.14.2',
  '5.12.0',
  '5.11.0',
  '5.9.7',
  '5.9.2',
  '5.9.0',
  '5.8.0',
  '5.7.0',
  '4.13.0',
  '3.5.17',
];

List<Uri> _getUrl() {
  final result = <Uri>[];
  for (final version in _versions) {
    result.add(Uri.https(
        'ajax.googleapis.com', '/ajax/libs/d3js/${version}/d3.min.js'));
  }

  return result;
}
