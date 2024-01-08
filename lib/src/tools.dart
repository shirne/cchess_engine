import 'dart:developer';

import 'package:logging/logging.dart';

final logger = _getLogger('CCHESS_ENGINE');

/// override logger level
Level _loggerLevel = Level.ALL;

bool _loggerListened = false;

Logger _getLogger(String name) {
  final logger = Logger('CCHESS');
  if (!_loggerListened && hierarchicalLoggingEnabled) {
    _loggerListened = true;
    logger.onRecord.listen((record) {
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
  }
  return logger;
}

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
