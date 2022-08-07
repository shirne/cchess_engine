import 'dart:isolate';

import 'package:cchess_engine/cchess_engine.dart';

void main(List<String> arguments) {
  ReceivePort rPort = ReceivePort();
  rPort.listen((message) {
    print(message);
  });
  Isolate.spawn<IsoMessage>(
    XQIsoSearch.getMove,
    IsoMessage(
        "C1bak4/7R1/2n1b4/1N4p1p/2pn1r3/P2R2P2/2P1cr2P/2C1B4/4A4/2BAK4 w - - 0 1",
        rPort.sendPort),
  );
}
