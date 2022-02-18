import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:mtoken_wallet/models/wallet_model.dart';
import 'package:mtoken_wallet/screens/coinlist.dart';
import 'package:mtoken_wallet/screens/wallet.dart';

class WalletMainPage extends StatefulWidget {
  const WalletMainPage({Key? key, required this.wallet}) : super(key: key);
  final Wallets wallet;
  @override
  _WalletMainPageState createState() => _WalletMainPageState();
}

class _WalletMainPageState extends State<WalletMainPage> {
  @override
  Widget build(BuildContext context) {
    final wallet = widget.wallet;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //leadingWidth: 50,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.bell),
            iconSize: 25,
            color: Colors.white,
          ),
          centerTitle: true,
          toolbarHeight: kToolbarHeight,
          title: SizedBox(
            //height: kToolbarHeight,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 25,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26, width: 2),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12, // Creates border
              ),
              child: TabBar(
                //labelPadding: const EdgeInsets.only(left: 30),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context)
                      .scaffoldBackgroundColor, // Creates border
                ),
                tabs: [
                  Tab(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Tokens',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Tab(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Finance',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Tab(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'NFT',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  )),
                ],
              ),
            ),
          ),

          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CoinList()));
              },
              icon: SvgPicture.asset(
                'assets/images/sliders-h-solid.svg',
                color: Colors.white,
                width: 25,
                height: 25,
              ),
              // Icon(Icons.switch_account_sharp),
              //iconSize: 15,
              //color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            )
          ],
          //shape: null,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: TabBarView(
          children: [
            Wallet(
              wallet: Wallets(
                  public: wallet.public,
                  private: wallet.private,
                  isCreated: wallet.isCreated,
                  xpud: wallet.xpud,
                  wallets: wallet.wallets,
                  phrase: wallet.phrase),
            ),
            const Text(
              'B',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Text(
              'C',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
