import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mtoken_wallet/pages/intro_page.dart';
import 'package:mtoken_wallet/pages/pin_login.dart';
import 'package:mtoken_wallet/utilities/wallet_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'models/wallet_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _user = SharedPreferences.getInstance();
  bool isLoading = false;
  bool isLogging = false;
  List<Wallets>? wallets;
  Wallets? walle;
  //bool isLoading2 = false;

  @override
  void initState() {
    downloadData();
    startTimer();
    super.initState();
  }

  startTimer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  void downloadData() async {
    final user = await _user;
    wallets = await WalletDatabase.instance.readAllWallets();
    isLogging = user.getBool('isLogging')!;
    walle = wallets?.first;
    if (walle != null) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isLoading =false;
      });
    }
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isLogging
            ? LogIn(
                wallet: Wallets(
                    isCreated: walle!.isCreated,
                    wallets: walle!.wallets,
                    private: walle!.private,
                    public: walle!.public,
                    phrase: walle!.phrase,
                    xpud: walle!.xpud),
              )
            : isLoading
                ? MyHomePage(
                    wallet: Wallets(
                        isCreated: walle!.isCreated,
                        wallets: walle!.wallets,
                        private: walle!.private,
                        public: walle!.public,
                        phrase: walle!.phrase,
                        xpud: walle!.xpud),
                  )
                : const IntroPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/safebox.png",
              width: 200,
              height: 200,
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const Text(
              'MOPS',
              style: TextStyle(fontSize: 50.0, color: Colors.blueAccent),
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// isLoading
// ? LogIn(
// wallet: Wallets(
// isCreated: wallet!.isCreated,
// wallets: wallet.wallets,
// private: wallet.private,
// public: wallet.public,
// phrase: wallet.phrase,
// xpud: wallet.xpud))
// : isLoading2
// ? wallet != null

// : const IntroPage()
// : const Center(child: CircularProgressIndicator()),
