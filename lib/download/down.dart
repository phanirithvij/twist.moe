import 'dart:io';

import 'package:twist_moe/file_size/filesize.dart';
import 'package:twist_moe/progress_bar/progress_bar.dart';

// Unrelated how to recieve SIGINT
// https://stackoverflow.com/q/20986142/8608146
const defaultHeaders = {
  "Referer": "https://twist.moe/",
  "User-Agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101 Firefox/69.0",
};

Future<void> download(
  String url,
  String path, {
  Map headers = defaultHeaders,
}) async {
  var downloadSize = 0;
  var totalSize = 0;

  print("Downloading to $path");

  final dile = File(path);
  final exists = dile.existsSync();
  var size = null;
  if (exists) {
    size = await dile.length();
    print("Resuming from the ${size} byte");
  }
  HttpClient client = HttpClient();
  final request = await client.getUrl(Uri.parse(url));
  if (headers != null) {
    headers.forEach((k, v) {
      request.headers.set(k, v);
    });
  }
  if (size != null) {
    request.headers.set("Range", "bytes=$size-");
  }

  request.close().then((HttpClientResponse response) {
    downloadSize = response.contentLength;
    final contentRange = response.headers['Content-Range'];
    if (contentRange != null && contentRange.length > 0) {
      final contentRangeStrs = contentRange[0].split(' ');
      if (contentRangeStrs.length > 1) {
        final size = contentRangeStrs.last.split('/').last;
        if (size != null) {
          totalSize = int.tryParse(size) ?? -1;
        }
      }
    }

    if (totalSize > 0 && downloadSize > 0) {
      final downloadSizeStr = filesize(totalSize - downloadSize);
      final totalSizeStr = filesize(totalSize);
      print("Current progress $downloadSizeStr/$totalSizeStr");
    }

    if (downloadSize == -1) {
      print("This file can't be resumed..");
      // This means the content length header is not present in the response
      // It can mean two things:
      // These kind of requests can't be resumed from last byte
    }
    final file = File(path).openWrite(mode: FileMode.writeOnlyAppend);
    final bar = ProgressBar(
      ":percent [:bar] :Hcurrent/:Htotal ETA :etas",
      total: downloadSize,
    );
    response.listen((data) async {
      file.add(data);
      // show progress bar
      if (downloadSize > 0) bar.tick(len: data.length);
    }, onError: (e) {
      print(e);
    }, onDone: () {
      print("Done");
      // file.close();
      // Only exit after closing the file
      file.close().then((e) => exit(0));
    });
  });
}

void main(List<String> args) {
  if (args.length < 2) {
    print("Usage: must pass two args");
    return;
  }
  String url = args[0];
  String path = args[1];
  download(url, path);
}
