// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:mtoken_wallet/models/coin_model.dart';
import 'package:mtoken_wallet/models/coinlist_model.dart';
import 'package:mtoken_wallet/screens/coin_detail.dart';

class WalletView extends StatelessWidget {
   const WalletView({
    Key? key,
     required this.name,
     required this.symbol,
     required this.imageUrl,
     required this.price,
     required this.changePercentage,
  }) : super(key: key);

  final String name;
   final String symbol;
   final String imageUrl;
   final num price;
   final num changePercentage;
  final double amount = 1000;
  //final bool loadImageError = false;
  @override
  Widget build(BuildContext context) {
    //double noPrice = 0;
    double total = amount * price;
    bool loadImageError = false;
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoinDetail(
              obj: Coin(name,symbol,imageUrl,price,changePercentage),
            ),
          ),
        );
      },
      tileColor: Theme.of(context).primaryColor,
      leading: CircleAvatar(
          radius: 20.0,
          backgroundColor: Theme.of(context).indicatorColor,
          backgroundImage: NetworkImage(imageUrl),
          onBackgroundImageError: (_, __) {
            if (kDebugMode) {
              print("Error loading image! ");
            }
            (() {
              loadImageError = true;
            });
          },
          child: loadImageError ? const Text("BEP 20") : null),
      title: Text(
        name,
      ),
      subtitle: Row(
        children: [
          Text('\$ $price'),
          const SizedBox(
            width: 5,
          ),
          Text(
            changePercentage.toDouble() < 0
                ? changePercentage.toDouble().toStringAsFixed(2) + '%'
                : '+' + changePercentage.toDouble().toStringAsFixed(2) + '%',
            style: TextStyle(
                color: changePercentage < 0 ? Colors.red : Colors.green),
          ),
        ],
      ),
      trailing: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            '$amount ${symbol.toUpperCase()}',
            style: const TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '\$ ${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
