import 'package:logger/logger.dart';

// printer apps state når programmet kører
final logger = Logger(
  printer: PrefixPrinter(
    PrettyPrinter(
      methodCount: 5,
      errorMethodCount: 5,
      lineLength: 80,
      printEmojis: false,
    ),
  ),
);
