import 'dart:convert';
import 'dart:io';

import 'package:twist_moe/consts.dart';

import 'twistapi.dart';

Future<List<Episode>> getUrls(String animeName) async {
  final apiUrl = "https://twist.moe/api/anime/$animeName/sources";
  final httpClient = new HttpClient();
  // This key should be obtained by inspecting the twist.moe api request headers
  final header = "1rj2vRtegS8Y60B3w3qNZm5T2Q0TN2NR";

  var episodes;
  try {
    final request = await httpClient.getUrl(Uri.parse(apiUrl));
    request.headers.set("x-access-token", header);
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      final jsonD = await response.transform(utf8.decoder).join();
      final parsed = json.decode(jsonD);
      episodes = (parsed as List).map((e) => Episode.fromJson(e)).toList();
    } else {
      throw NetworkError(failedMessage(response, animeName));
    }
  } catch (exception) {
    throw exception;
  }
  return episodes;
}

class NetworkError implements Exception {
  final String message;
  const NetworkError(this.message);
  @override
  String toString() => message;
}
