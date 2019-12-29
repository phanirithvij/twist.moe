import 'dart:io';

import 'package:twist_moe/file_size/filesize.dart';
import 'package:twist_moe/progress_bar/progress_bar.dart';

void download(String url, String path) async {
  var downloadSize = 0;

  final dile = File(path);
  final exists = dile.existsSync();
  var size;
  if (exists) {
    size = await dile.length();
    print(size);
  }
  HttpClient client = HttpClient();
  final request = await client.getUrl(Uri.parse(url));
  if (size != null) {
    request.headers.set("Range", "bytes=$size-");
  }
  request.close().then((HttpClientResponse response) {
    downloadSize = response.contentLength;
    final downloadSizeStr = filesize(downloadSize);
    // response.headers.forEach((f, s) {
    //   print(f);
    //   print(s);
    //   print('-' * 19);
    // });
    print(response.headers['Content-Range'][0].split(' ').last.split('/').last);
    print("dowload size is $downloadSizeStr");
    if (downloadSize <= 0) {
      // This means the content length header is not present in the response
      // It can mean two things:
      // This type of requests can't be resumed from last byte
      // Or
      // The file is already done downloading and we thus must NOT write to the file
    }
    final file = File(path).openWrite(mode: FileMode.writeOnlyAppend);
    final bar = ProgressBar(
      ":percent [:bar] :Hcurrent/:Htotal",
      total: downloadSize,
    );
    response.listen((data) {
      file.add(data);
      // show progress bar
      bar.tick(len: data.length);
    }).onDone(() {
      print("Done");
      file.close();
      exit(0);
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
  print("Downloading $url to $path");
  download(url, path);
}
