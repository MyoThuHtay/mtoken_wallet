import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:mtoken_wallet/pages/wallet_mainpage.dart';
//import 'package:mtoken_wallet/utilities/firestore.dart';
import 'package:mtoken_wallet/utilities/wallet_creation.dart';

import 'confirm_mnemonic.dart';

class Recovery extends StatelessWidget {
  const Recovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletAddress service = WalletAddress();
    final mnemonic = service.generateMnemonic();
    List mem = mnemonic.split(" ");
    TextEditingController name = TextEditingController();
    final snackBar = SnackBar(
      content: const Text('Copied to Clipboard'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            const Center(
              child: Text(
                'Your Recovery Phrase',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            const SizedBox(
              width: 300,
              height: 50,
              child: Center(
                child: Text(
                  'Write down or copy these words in the right order and save them somewhere Safe.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 350,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 1 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[0],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 2 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[1],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 3 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[2],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 4 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[3],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 350,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 5 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[4],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 6 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[5],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 7 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[6],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 8 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[7],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 9 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[8],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 10 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[9],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 11 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[10],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            ' 12 ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            mem[11],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: mnemonic))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    },
                    child: Text('Copy',style: TextStyle(color:Theme.of(context).scaffoldBackgroundColor, ),),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Show QR',style: TextStyle(color:Theme.of(context).scaffoldBackgroundColor, ),),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.red.shade100,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  const Icon(
                    Icons.warning_sharp,
                    color: Colors.red,
                  ),
                  const Text(
                    'Never Share recovery phrase with anyone,store it Safely.',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).scaffoldBackgroundColor),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComfirmMnemonic(
                        name: name.text,
                        mne: mnemonic,
                      ),
                    ),
                  );
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
