import 'dart:typed_data';
import 'package:bech32/bech32.dart';

import 'package:bitcoin_flutter/src/utils/script.dart' as bscript;
import 'package:bitcoin_flutter/src/utils/constants/op.dart';
import 'package:bitcoin_flutter/src/crypto.dart' show hashSha256;
import 'package:bitcoin_flutter/src/payments/multisig.dart';
import 'package:bitcoin_flutter/src/models/networks.dart';

class P2WSH {
  Uint8List scriptHash;

  P2WSH.fromScriptHash(Uint8List hash) : scriptHash = hash {
    if (scriptHash.length != 32) {
      throw ArgumentError('Invalid script hash length');
    }
  }
  P2WSH.fromScriptBytes(Uint8List bytes)
      : this.fromScriptHash(hashSha256(bytes));
  P2WSH.fromMultisig(MultisigScript script)
      : this.fromScriptBytes(script.scriptBytes);

  /// Returns the outputScript (scriptPubKey)
  Uint8List get outputScript => bscript.compile([OPS['OP_0'], scriptHash]);

  /// Returns the bech32 address for a given network
  String address(NetworkType network) =>
      segwit.encode(Segwit(network.bech32, 0, scriptHash));
}
