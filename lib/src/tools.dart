import 'dart:developer';

import 'package:logging/logging.dart';

final logger = Logger('CCHESS_ENGINE')
  ..onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      level: record.level.value,
      error: record.error,
      stackTrace: record.stackTrace,
      sequenceNumber: record.sequenceNumber,
    );
  });
