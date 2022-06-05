import 'dart:convert';

import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bech32/bech32.dart';
import 'package:bitcoin_flutter/src/payments/p2pk.dart';
import 'package:bitcoin_flutter/src/payments/p2wsh.dart';
import 'package:bitcoin_flutter/src/utils/constants/op.dart';
import 'package:bitcoin_flutter/src/utils/script.dart' as bscript;
import 'package:hex/hex.dart';

main() {
  final alice = ECPair.fromWIF(
      'cNGupyDhyzw44RKfNX61uWYeywc1Rbw6ozpZrvpBNEgG7R1jconA',
      network: regtest);

  final txb = new TransactionBuilder(network: regtest);

  //print(p2wpkh.address);
  //print(Address.addressToOutputScript(p2wpkh.address, regtest));
  txb.addInput(
    '31ea54998f26129bffe2c4ee53c3aa4614195f11b4aa770bf0e5eae78c8d35b4',
    0,
  ); // Alice's previous transaction output, has 15000 satoshis
  print(txb.inputs[0].prevOutType);
  txb.addNullOutput('ADD:BTC.BTC:tthor1zf3gsk7edzwl9syyefvfhle37cjtql35h6k85m');
  txb.addOutput('bcrt1q8fcchv766vdnwzqme7xhkn3uyytrlfmprn7dun', 70000000);

  txb.sign(vin: 0, keyPair: alice);

  print(txb.build().toHex());
}
