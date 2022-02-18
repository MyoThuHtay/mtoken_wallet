// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mtoken_wallet/models/coinlist_model.dart';
import 'package:mtoken_wallet/models/wallet_model.dart';
import 'package:mtoken_wallet/screens/wallet_view.dart';
import 'package:mtoken_wallet/utilities/wallet_database.dart';
//import 'package:mtoken_wallet/utilities/wallet_database.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key, required this.wallet}) : super(key: key);
  final Wallets wallet;
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  Wallets? wallet;
  final String apiKey = 'N3GR42WKJQRPZZZ81YH3BPZJB25RYID59R';
   bool isLoading = false;
  Future refreshWallets() async {
    wallet = await WalletDatabase.instance.readWallet(widget.wallet.public);
    setState(() {
      isLoading = true;
    });
    if (wallet?.isCreated == true) {
      if (kDebugMode) {
        print(wallet?.public);
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
    return wallet;
  }

//https://deep-index.moralis.io/api/v2/0xE887232387645C90601935FC028D0589d97942eb/erc20?chain=bsc
  //https://api-testnet.bscscan.com/api?module=account&action=balance&address=0xE887232387645C90601935FC028D0589d97942eb&apikey=$apiKey
  //https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false

  var coinIdList = [
    'bitcoin',
    'binancecoin',
    'ethereum',
    'tether',
  ];

  Future<List<Coin>> fetchCoin() async {
    coinList = [];

    final response = await http.get(
      Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false'),
    );
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }

        setState(() {
          isLoading = true;
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load Coins');
    }
  }

  Future readWallet() async {
    final String? pubAddress = widget.wallet.public;
    final response = await http.get(Uri.parse(
        'https://api-testnet.bscscan.com/api?module=account&action=balance&address=$pubAddress&apikey=$apiKey'));
    if (response.statusCode == 200) {
      var balance = jsonDecode(response.body);
       if (kDebugMode) {
         print(pubAddress);
         print(balance);
       }

      return balance;
    }
  }

  @override
  void initState() {
    //readWallet();
    fetchCoin();
    //fetch();
    refreshWallets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double all = 20000;
    String symbol = '\$';
    final name = widget.wallet.wallets;
    //final id = widget.wallet.id;
    return LiquidPullToRefresh(
      showChildOpacityTransition: true,
      onRefresh: () async {
        setState(() {});
        await fetchCoin();
      },
      child: isLoading
          ? ListView.builder(
              itemCount: coinList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ListTile(
                    title: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 240,
                          child: Card(
                            elevation: 0,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  '$symbol ${all.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    name ,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            //border: Border.all(color: Colors.black26, width: 2),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                Colors.blue, // Creates border
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              readWallet();
                                            },
                                            icon: const Icon(CupertinoIcons
                                                .arrow_up_to_line),
                                            iconSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Send',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            //border: Border.all(color: Colors.black26, width: 2),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                Colors.blue, // Creates border
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              //fetch();
                                            },
                                            icon: const Icon(CupertinoIcons
                                                .arrow_down_to_line),
                                            iconSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Receive',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                Colors.blue, // Creates border
                                          ),
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  CupertinoIcons.bookmark),
                                              iconSize: 30,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'Buy',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                index -= 1;
                return WalletView(
                  name: coinList[index].name,
                  symbol: coinList[index].symbol,
                  imageUrl: coinList[index].imageUrl,
                  price: coinList[index].price.toDouble(),
                  changePercentage: coinList[index].changePercentage.toDouble(),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
