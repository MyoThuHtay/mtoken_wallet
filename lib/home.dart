// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtoken_wallet/screens/dapp.dart';
import 'package:mtoken_wallet/screens/dex.dart';
import 'package:mtoken_wallet/screens/setting.dart';
import 'package:mtoken_wallet/pages/wallet_mainpage.dart';
//import 'package:mtoken_wallet/utilities/wallet_database.dart';

import 'models/wallet_model.dart';
//import 'package:mtoken_wallet/utilities/wallet_database.dart';

//import 'models/wallet_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.wallet}) : super(key: key);
  final Wallets wallet;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Wallets? wallet;
  final String apiKey = 'N3GR42WKJQRPZZZ81YH3BPZJB25RYID59R';
  //final wallet = widget.wallet;
  // Future refreshWallets() async {
  //   wallet = await WalletDatabase.instance.readWallet(widget.wallet.id);
  //   return wallet;
  // }

  // @override
  // void initState() {
  //   refreshWallets();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final wallet = widget.wallet;

    List<Widget> _pages = <Widget>[
      WalletMainPage(
          wallet: Wallets(
              isCreated: wallet.isCreated,
              wallets: wallet.wallets,
              private: wallet.private,
              public: wallet.public,
              phrase: wallet.phrase,
              xpud: wallet.xpud)),
      const Dapp(),
      const Dex(),
      Setting(wallet: Wallets(
          isCreated: wallet.isCreated,
          wallets: wallet.wallets,
          private: wallet.private,
          public: wallet.public,
          phrase: wallet.phrase,
          xpud: wallet.xpud)),
    ];
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        currentIndex: _selectedIndex,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        iconSize: 30.0,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.shield_fill,
              //color: Colors.black,
            ),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.square_grid_2x2_fill,
              //color: Colors.black,
            ),
            label: ("DAPP"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.arrow_right_arrow_left,
              //color: Colors.black
            ),
            label: "DEX",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.gear_solid,
              //color: Colors.black
            ),
            label: 'Setting',
          ),
        ],
      ),
    );

    //int _selectedIndex =0;
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
