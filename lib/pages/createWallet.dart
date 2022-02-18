// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mtoken_wallet/models/wallet_model.dart';
import 'package:mtoken_wallet/pages/intro_page.dart';
//import 'package:mtoken_wallet/pages/wallet_mainpage.dart';
import 'package:mtoken_wallet/screens/wallet_detail.dart';
// import 'package:mtoken_wallet/utilities/wallet_creation.dart';
// import 'package:mtoken_wallet/utilities/firestore.dart';
import 'package:mtoken_wallet/utilities/wallet_database.dart';

import '../home.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({Key? key}) : super(key: key);

  @override
  State<CreateWallet> createState() => _CreateWallet();
}

class _CreateWallet extends State<CreateWallet> {
  late List<Wallets> wallets;
  bool isLoading = false;
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    refreshWallets();
  }

  // @override
  // void dispose() {
  //   WalletDatabase.instance.close();
  //   super.dispose();
  // }
  Wallets? wallet;
  Future refreshWallets() async {
    setState(() {
      isLoading = true;
    });
    wallets = await WalletDatabase.instance.readAllWallets();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //var ids = wallet?.id ?? 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Wallets Information"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const IntroPage(
                      //id: ids,
                      ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : wallets.isEmpty
                  ? const Text('No Wallets')
                  : buildWallets()),
    );
  }

  Widget buildWallets() => ListView.builder(
        itemCount: wallets.length,
        itemBuilder: (context, index) {
          final wallet = wallets[index];

          return ListTile(
            onTap: () {
              setState(() {
                isSelected = true;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    wallet: Wallets(
                        isCreated: wallet.isCreated,
                        private: wallet.private,
                        public: wallet.public,
                        wallets: wallet.wallets,
                        phrase: wallet.phrase,
                        xpud: wallet.xpud),
                  ),
                ),
              );
            },
            leading: CircleAvatar(
              child: Image.asset(
                'assets/images/safebox.png',
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('Wallet ${wallet.id}'),
            subtitle: Text(wallet.wallets),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WalletDetail(wallet: Wallets(
                        isCreated: wallet.isCreated,
                        private: wallet.private,
                        public: wallet.public,
                        wallets: wallet.wallets,
                        phrase: wallet.phrase,
                        xpud: wallet.xpud),),
                  ),
                );
              },
            ),
          );
        },
      );
}
