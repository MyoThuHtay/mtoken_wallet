//import 'dart:typed_data';

//import 'package:bip32/bip32.dart';
import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:web3dart/web3dart.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter/foundation.dart';
import 'package:hex/hex.dart';
//import 'package:web3dart/web3dart.dart';
// import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:convert/convert.dart';
// import 'dart:convert';

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
}

class WalletAddress implements WalletAddressService {
  @override
  String generateMnemonic() {
    var mnemonic = bip39.generateMnemonic();
    return mnemonic;
    //return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    return privateKey;
  }

  Future<String> getXpudKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final node = bip32.BIP32.fromSeed(seed);
    final xPud = node.neutered().toBase58();
    //final xPud = node.derivePath("m/44' /0/0");
    return xPud.toString();
  }

  @override
  Future<EthereumAddress> getPublicKey(String mnemonic) async {
    Chain chain = Chain.seed(hex.encode(utf8.encode(mnemonic)));
    ExtendedPrivateKey privateKey = chain.forPath("m/44'/60'/0'/0/0") as ExtendedPrivateKey;
    Credentials private = EthPrivateKey.fromHex(privateKey.privateKeyHex());
    final address = await private.extractAddress();

    if (kDebugMode) {
      print('address: ${address.toString()}');
    }
    return address;
  }
}
