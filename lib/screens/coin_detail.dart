// ignore_for_file: prefer_const_literals_to_create_immutables, constant_identifier_names, unused_import
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
//import 'package:mtoken_wallet/models/coin_model.dart';
import '../models/coinlist_model.dart';

class CoinDetail extends StatefulWidget {
  const CoinDetail({
    Key? key,
    required this.obj,
  }) : super(key: key);

  final Coin obj;


  @override
  _CoinDetailState createState() => _CoinDetailState();
}

class _CoinDetailState extends State<CoinDetail> {


  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    //String id = 'usd';
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false'));
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
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load Coins');
    }
  }

  @override
  Widget build(BuildContext context) {

    double amount = 1000;
    //double total = amount * widget.obj.price;
    bool loadImageError = false;
    // 0xbash

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.obj.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Text('BUY'),
            iconSize: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.chartBar),
            iconSize: 20,
          )
        ],

      ),
      //backgroundColor: Theme.of(context).primaryColor,
      body: LiquidPullToRefresh(
        showChildOpacityTransition: true,
        onRefresh: () async {
          setState(() {});
          await fetchCoin();
        },
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return ListTile(
                //elevation: 0,
                tileColor: Theme.of(context).primaryColor,
                title: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: const Text(
                              'BEP 20',
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              '\$ ${widget.obj.price}',
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.obj.changePercentage.toDouble() < 0
                                ? widget.obj.changePercentage
                                .toDouble()
                                .toStringAsFixed(2) +
                                '%'
                                : '+' +
                                widget.obj.changePercentage
                                    .toDouble()
                                    .toStringAsFixed(2) +
                                '%',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: widget.obj.price < 0
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Theme.of(context).indicatorColor,
                          // ignore: unnecessary_null_comparison
                          backgroundImage: NetworkImage(widget.obj.imageUrl),
                          onBackgroundImageError: (_, __) {
                            //print("Error loading image! " + exception.toString());
                            (() {
                              loadImageError = true;
                            });
                          },
                          child: loadImageError ? const Text("BEP 20") : null),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        '$amount ${widget.obj.symbol.toUpperCase()}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                      child: Text(
                        '= \$ 20000',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue, // Creates border
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon:
                                const Icon(CupertinoIcons.arrow_up_to_line),
                                iconSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Send',
                              style:
                              TextStyle(fontSize: 15, color: Colors.blue),
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
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue, // Creates border
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    CupertinoIcons.arrow_down_to_line),
                                iconSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Receive',
                              style:
                              TextStyle(fontSize: 15, color: Colors.blue),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Container(
                              //color: Colors.blue,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue, // Creates border
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(CupertinoIcons.doc_on_doc),
                                  iconSize: 30,
                                  color: Colors.white),
                            ),
                            const Text(
                              'Copy',
                              style:
                              TextStyle(fontSize: 15, color: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // const Divider(
                    //   thickness: 1,
                    // ),
                  ],
                ),
              );
            }
            index -= 1;
            return Column(
              children: [
                const Divider(
                  thickness: .5,
                  height: .5,
                  color: Colors.black38,
                ),
                ListTile(
                  tileColor: Theme.of(context).primaryColor,
                  leading: const Icon(
                    CupertinoIcons.arrow_down_to_line,
                    size: 30,
                  ),
                  title: const Text('Transfer'),
                  subtitle:  const Text('From: '),
                  trailing: Text('$amount ${widget.obj.symbol.toUpperCase()}'),
                ),
                // const Divider(
                //   thickness: .5,
                //   height: .5,
                //   color: Colors.black38,
                // ),
              ],
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
