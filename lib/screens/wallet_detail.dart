import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtoken_wallet/models/wallet_model.dart';
import 'package:mtoken_wallet/pages/createWallet.dart';
import 'package:mtoken_wallet/utilities/wallet_database.dart';

class WalletDetail extends StatefulWidget {
  const WalletDetail({Key? key, required this.wallet}) : super(key: key);
  final Wallets wallet;
  @override
  _WalletDetailState createState() => _WalletDetailState();
}

class _WalletDetailState extends State<WalletDetail> {
  @override
  void initState() {
    super.initState();
    refreshWallets();
  }

  Wallets? wallet;
  bool isLoading = false;

  TextEditingController editor = TextEditingController();
  Future refreshWallets() async {
    setState(() {
      isLoading = true;
    });
    wallet = await WalletDatabase.instance.readWallet(widget.wallet.public);
    setState(() {
      isLoading = false;
    });
  }

  final snackBar = SnackBar(
    content: const Text('Copied to Clipboard'),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {},
    ),
  );

  // update(value) async {
  //   var value = await WalletDatabase.instance.update(wallet);
  //   //return value;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Wallet'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await WalletDatabase.instance.delete(wallet?.id);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const CreateWallet()));
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).iconTheme.color,
              ))
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 60,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Theme.of(context).indicatorColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      // Creates border
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:Text(wallet!.wallets),

                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 60,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Theme.of(context).indicatorColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      // Creates border
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(wallet!.public.toString()),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 60,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Theme.of(context).indicatorColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      // Creates border
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: wallet!.phrase))
                              .then((value) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            wallet!.phrase,
                            style: const TextStyle(
                                color: Colors.grey,
                                backgroundColor: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
