library filesize;

/**
 * method returns a human readable string representing a file size
 *
 * size can be passed as number or as string
 *
 * the optional parameter 'count' specifies the number of numbers after comma/point (default is 2)
 *
 * the optional boolean parameter 'decimal' specifies if the decimal system should be used, e.g. 1KB = 1000B (default is false)
 *
 *  */
String filesize(size, [int round = 2, bool decimal = false]) {
  int divider = 1024;

  size = int.parse(size.toString());

  if (decimal) divider = 1000;

  if (size < divider) return "$size B";

  if (size < divider * divider && size % divider == 0)
    return "${(size / divider).toStringAsFixed(0)} KB";

  if (size < divider * divider)
    return "${(size / divider).toStringAsFixed(round)} KB";

  if (size < divider * divider * divider && size % divider == 0)
    return "${(size / (divider * divider)).toStringAsFixed(0)} MB";

  if (size < divider * divider * divider)
    return "${(size / divider / divider).toStringAsFixed(round)} MB";

  if (size < divider * divider * divider * divider && size % divider == 0)
    return "${(size / (divider * divider * divider)).toStringAsFixed(0)} GB";

  if (size < divider * divider * divider * divider)
    return "${(size / divider / divider / divider).toStringAsFixed(round)} GB";

  if (size < divider * divider * divider * divider * divider &&
      size % divider == 0)
    return "${(size / divider / divider / divider / divider).toStringAsFixed(0)} TB";

  if (size < divider * divider * divider * divider * divider)
    return "${(size / divider / divider / divider / divider).toStringAsFixed(round)} TB";

  if (size < divider * divider * divider * divider * divider * divider &&
      size % divider == 0) {
    return "${(size / divider / divider / divider / divider / divider).toStringAsFixed(0)} PB";
  } else {
    return "${(size / divider / divider / divider / divider / divider).toStringAsFixed(round)} PB";
  }
}
