import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtoken_wallet/pages/intro_page.dart';
import 'package:mtoken_wallet/pages/pin_login.dart';
import 'package:mtoken_wallet/theme_provider.dart';
import 'package:mtoken_wallet/utilities/wallet_database.dart';
//import 'package:mtoken_wallet/utilities/sign_in_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'models/wallet_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _user = SharedPreferences.getInstance();
  bool isLogging = false;
  readUser() async {
    final user = await _user;

    isLogging = user.getBool('isLogging')!;

    if (kDebugMode) {
      print(isLogging.toString());
    }
  }

  List<Wallets>? wallets;
  bool isLoading2 = false;
  readWallet() async {
    setState(() {
      isLoading2 = true;
    });
    wallets = await WalletDatabase.instance.readAllWallets();
    setState(() {
      isLoading2 = false;
    });
  }

  @override
  void initState() {
    readUser();
    readWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = isLogging;
    final wallet = wallets?.first;
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(context),
      child: Builder(builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: isLoading
              ? LogIn(
                  wallet: Wallets(
                      isCreated: wallet!.isCreated,
                      wallets: wallet.wallets,
                      private: wallet.private,
                      public: wallet.public,
                      phrase: wallet.phrase,
                      xpud: wallet.xpud),
                )
              : isLoading2
                  ? wallet != null
                      ? MyHomePage(
                          wallet: Wallets(
                              isCreated: wallet.isCreated,
                              wallets: wallet.wallets,
                              private: wallet.private,
                              public: wallet.public,
                              phrase: wallet.phrase,
                              xpud: wallet.xpud))
                      : const IntroPage()
                  : const CircularProgressIndicator(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
