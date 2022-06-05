import 'dart:typed_data';
import 'package:bitcoin_flutter/src/utils/script.dart' as bscript;
import 'package:bitcoin_flutter/src/utils/constants/op.dart';

bool inputCheck(List<dynamic> chunks) {
  return chunks.length == 1 && bscript.isCanonicalScriptSignature(chunks[0]);
}

bool outputCheck(Uint8List script) {
  // TODO
}
