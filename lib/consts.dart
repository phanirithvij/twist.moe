String failedMessage(response, animeName) {
  return "-" * 78 +
      """\n
Failed to get episodes ${response.statusCode}
Please check the url is this $animeName the anime name?
""" +
      "-" * 78;
}
