import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

/// Service which gives access to `logger` and
/// helper methods to easily log stuff to the console
class LoggerService extends GetxService {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 50,
      noBoxingByDefault: true,
    ),
  );

  /// ------------------------
  /// METHODS
  /// ------------------------

  /// Verbose log, grey color
  void v(value) => logger.v(value);

  /// 🐛 Debug log, blue color
  void d(value) => logger.d(value);

  /// 💡 Info log, light blue color
  void i(value) => logger.i(value);

  /// ⚠️ Warning log, orange color
  void w(value) => logger.w(value);

  /// ⛔ Error log, red color
  void e(value) => logger.e(value);

  /// 👾 What a terrible failure log, purple color
  void wtf(value) => logger.wtf(value);

  /// Logs JSON responses with proper formatting
  void logJson(String data, {bool isError = false}) {
    final object = json.decode(data);
    final prettyString = const JsonEncoder.withIndent('  ').convert(object);
    isError ? logger.e(prettyString) : logger.i(prettyString);
  }
}
