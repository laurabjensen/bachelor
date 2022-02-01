import 'package:logger/logger.dart';

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
