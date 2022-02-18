import 'package:flutter/material.dart';
import 'package:mtoken_wallet/models/wallet_model.dart';

//import 'package:mtoken_wallet/utilities/firestore.dart';
import 'package:mtoken_wallet/utilities/wallet_creation.dart';
import 'package:mtoken_wallet/utilities/wallet_database.dart';

import '../home.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ComfirmMnemonic extends StatefulWidget {
  const ComfirmMnemonic({Key? key, required this.mne, required this.name})
      : super(key: key);

  final String mne;
  final String name;

  @override
  _ComfirmMnemonicState createState() => _ComfirmMnemonicState();
}

TextEditingController editor = TextEditingController();

class _ComfirmMnemonicState extends State<ComfirmMnemonic> {
  String? pubAddress;
  String? privAddress;
  String? username;
  String? phrase;
  late bool isCreated;

  //int id = 1;

  Future addWallet(isCreated, wallets, private, public, phrase, xpud) async {
    final wallet = Wallets(
      phrase: phrase.toString(),
      private: private.toString(),
      public: public.toString(),
      xpud: xpud.toString(),
      wallets: 'My Wallet',
      isCreated: isCreated,
    );

    await WalletDatabase.instance.create(wallet);
  }

  @override
  void dispose() {
    super.dispose();
    editor.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            const Text(
              'Verify Recovery Phrase',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0),
              child: Text(
                'Write Or Paste the Recovery Phrase.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.grey.shade300,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 50.0, top: 30, right: 50),
                  child: TextField(
                    controller: editor,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    minLines: 4,
                    maxLines: 5,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).scaffoldBackgroundColor),
              ),
              onPressed: () async {
                if (editor.text == widget.mne) {
                  WalletAddress service = WalletAddress();
                  final wallet = widget.name;
                  final mnemonic = widget.mne;
                  final privateKey = await service.getPrivateKey(mnemonic);
                  final publicKey = await service.getPublicKey(privateKey);
                  final xPud = await service.getXpudKey(mnemonic);
                  //const id = 1;
                  const bool isCreated = true;
                  addWallet(
                      isCreated, wallet, privateKey, publicKey, mnemonic, xPud);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        wallet: Wallets(
                            isCreated: isCreated,
                            wallets: wallet,
                            private: privateKey,
                            public: publicKey.toString(),
                            phrase: mnemonic,
                            xpud: xPud),
                      ),
                    ),
                  );
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 15,
                child: const Center(
                  child: Text('Done'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
