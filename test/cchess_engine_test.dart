import 'dart:io';

import 'package:cchess/cchess.dart';
import 'package:cchess_engine/cchess_engine.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

void main() {
  final logger = Logger.root;
  logger.onRecord.listen((record) {
    stdout.writeln('${record.level.name}: ${record.time}: ${record.message}');
  });

  /// xqlite 招法转换测试
  test('test IccsMove', () {
    List<String> iccs = [
      'b0c2',
      'h9g7',
      'h0g2',
      'b9c7',
      'f0e1',
      'i9i8',
      'a0a1',
      'b7a7',
      'g3g4',
      'i8f8',
    ];
    List<int> moves = [
      42436,
      22842,
      43466,
      21812,
      47048,
      19259,
      46019,
      21332,
      35225,
      18507,
    ];

    for (int i = 0; i < iccs.length; i++) {
      expect(Util.iccs2Move(iccs[i]), moves[i]);
      expect(Util.move2Iccs(moves[i]), iccs[i]);
    }
  });

  test('test bookSearch', () async {
    int startMillionSec = DateTime.now().millisecondsSinceEpoch;
    logger.info(startMillionSec);

    Position position = Position();
    Search search = Search(position, 12);
    Position.init();
    logger.info(
        '初始化耗时：${DateTime.now().millisecondsSinceEpoch - startMillionSec}毫秒');
    startMillionSec = DateTime.now().millisecondsSinceEpoch;

    int step = 0;
    ChessFen fen = ChessFen();
    while (step < 10) {
      position.fromFen('${fen.fen} ${step % 2 == 0 ? 'w' : 'b'} - - 0 $step');
      int mvLast = search.searchMain(1000 << (1 << 1));
      String move = Util.move2Iccs(mvLast);
      logger.info('$mvLast => $move => ${fen.toChineseString(move)}');
      fen.move(move);

      logger.info(
          '耗时：${DateTime.now().millisecondsSinceEpoch - startMillionSec}毫秒');
      startMillionSec = DateTime.now().millisecondsSinceEpoch;
      step++;
    }
  });
}
