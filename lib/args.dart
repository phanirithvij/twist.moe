import 'package:args/args.dart';

/// Builds an arg parser for this.
/// Seperated to a different file because it's too long.
ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      "help",
      abbr: 'h',
      negatable: false,
      defaultsTo: false,
      help: "Shows this help message",
    )
    ..addFlag(
      "download",
      abbr: 'd',
      defaultsTo: false,
      help: "Download the episodes",
    )
    ..addOption(
      'start',
      abbr: 's',
      defaultsTo: '1',
      valueHelp: "number",
      help: "The start value.",
    )
    ..addOption(
      'end',
      abbr: 'e',
      valueHelp: "number",
      help: """The end episode to download.
Defaults to the last episode in the list.
Specify --count or -c for specifying number of episodes instead.
        """
          .trim(),
    )
    ..addOption(
      'count',
      abbr: 'c',
      valueHelp: "number",
      help: """The number of episodes to download.
Specify --end or -e for specifying the end instead.
      """
          .trim(),
    )
    ..addOption(
      'if',
      abbr: 'i',
      valueHelp: "path to list.txt",
      help: """
      Path to a urls.txt file
      IMPORTANT: Must pass the name of the anime when using this flag.
      Using: --name "anime name" option.
      """
          .trim(),
    )
    ..addOption(
      'name',
      abbr: 'n',
      defaultsTo: 'episode',
      valueHelp: "Anime name",
      help: """
      Using: --name "anime name" option.
      This name will be used to replace the ":name" when formatting the episode names after downloading.
      Default value will be "episode" when using with --if(-i).
      Default value when downloading directly from url the name is extracted from the url
      This will override that name.
      """
          .trim(),
    )
    ..addOption(
      'format',
      abbr: 'f',
      defaultsTo: ':name-:Pnumber',
      valueHelp: "format",
      help: """
      The format of the episode output name.
Examples: ':number-:Pnumber-:name'
  You can pass just ':number' to get 1.mp4, 2.mp4 etc.
  ':Pnumber' is for padded numbers i.e. 1 will be 001, 300 will be 300
Defaults to :name-:Pnumber.mp4.
"""
          .trim(),
    )
    ..addOption(
      'dir',
      abbr: 'o',
      defaultsTo: './Anime/',
      valueHelp: "destination directory",
    );
}
