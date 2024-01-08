import 'dart:developer';

import 'package:logging/logging.dart';

/// override logger level
Level _loggerLevel = Level.ALL;

final logger = Logger('CCHESS_ENGINE')
  ..onRecord.listen((record) {
    if (_loggerLevel.value > record.level.value) {
      return;
    }
    log(
      record.message,
      time: record.time,
      level: record.level.value,
      error: record.error,
      stackTrace: record.stackTrace,
      sequenceNumber: record.sequenceNumber,
    );
  });

/// control package
class CChessEngine {
  /// close log of cchess package
  static void closeLog() {
    _loggerLevel = Level.OFF;
  }

  /// default to log info level
  static void openLog() {
    _loggerLevel = Level.INFO;
  }

  /// set log level of cchess package
  static set logLevel(Level level) {
    _loggerLevel = level;
  }
}
