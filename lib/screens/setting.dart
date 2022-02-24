import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtoken_wallet/models/wallet_model.dart';
import 'package:mtoken_wallet/pages/createWallet.dart';
import 'package:mtoken_wallet/pages/read_pin.dart';
import 'package:mtoken_wallet/theme_provider.dart';
//import 'package:mtoken_wallet/utilities/wallet_database.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter_svg/flutter_svg.dart';

import 'currency_list.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key,required this.wallet}) : super(key: key);
final Wallets wallet;
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // Wallets? wallet;
  // Future readWallet() async {
  //  wallet = await WalletDatabase.instance.readWallet(widget.id);
  //  return wallet;
  // }
  // @override
  // void initState() {
  //   readWallet();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final name = widget.wallet.wallets;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Settings'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green, // Creates border
                ),
                child: const Icon(
                  Icons.account_balance_wallet_sharp,
                  //FontAwesomeIcons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text('Wallets'),
              subtitle: Text(name),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const CreateWallet()));
                },
              ),

            ),
            const Divider(
              height: .5,
              color: Colors.black12,
              thickness: .5,
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black, // Creates border
                ),
                child: const Icon(
                  CupertinoIcons.moon_stars_fill,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text('Dark Mode'),
              trailing: Switch.adaptive(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    final provider =
                    Provider.of<ThemeProvider>(context, listen: false);
                    provider.toggleTheme(value);
                  }),
            ),
            const Divider(
              height: .5,
              color: Colors.black12,
              thickness: .5,
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey, // Creates border
                ),
                child: const Icon(
                  CupertinoIcons.lock,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text('Security'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const CreatePin()));
                },
              ),
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red, // Creates border
                ),
                child: const Icon(
                  CupertinoIcons.app_badge,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text('Push Notifications'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.greenAccent, // Creates border
                ),
                child:
                const Icon(
                  CupertinoIcons.book,
                  color: Colors.white,
                  size: 30,
                ),
              ),

              title: const Text('Preferences'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
            const Divider(
              height: .5,
              color: Colors.black12,
              thickness: .5,
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red, // Creates border
                ),
                child: const Icon(
                  CupertinoIcons.money_dollar,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text('Currency'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const CurrencyList( )));
                },
              ),
            ),
            const Divider(
              height: .5,
              color: Colors.black12,
              thickness: .5,
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red, // Creates border
                ),
                child: const Icon(
                  Icons.monetization_on,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text('Price Alert'),
              //subtitle: const Text('this is a description of the motivation'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
            const Divider(
              height: .5,
              color: Colors.black12,
              thickness: .5,
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blueAccent, // Creates border
                ),
                child: const Icon(
                  CupertinoIcons.arrow_2_circlepath,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text('Wallet Connect'),
              //subtitle: const Text('this is a description of the motivation'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
            const Divider(
              height: .5,
              color: Colors.black12,
              thickness: .5,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: 350,
                  height: 20,
                  child: Text(
                    'Join Community',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.black26, width: 2),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.orangeAccent, // Creates border
                    ),
                    child: const Icon(
                      Icons.help_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: const Text('Help Center'),
                  //subtitle: const Text('this is a description of the motivation'),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.black26, width: 2),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueAccent, // Creates border
                    ),
                    child: const Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: const Text('Twitter'),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.black26, width: 2),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue, // Creates border
                    ),
                    child: const Icon(
                      FontAwesomeIcons.telegram,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: const Text('Telegram'),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.black26, width: 2),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue.shade800, // Creates border
                    ),
                    child: const Icon(
                      FontAwesomeIcons.facebookSquare,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: const Text('FaceBook'),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const Divider(
              height: .5,
              color: Colors.black12,
              thickness: .5,
            ),
            ListTile(
              //tileColor: Theme.of(context).primaryColor,
              leading: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black26, width: 2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red, // Creates border
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text('About'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
