//import 'package:flutter/material.dart';

class Coin {
  Coin(
    //@required this.id,
    this.name,
    this.symbol,
    this.imageUrl,
    this.price,
    this.changePercentage,
  );
  //String id;
  String name;
  String symbol;
  String imageUrl;
  num price;
  num changePercentage;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(json['name'], json['symbol'], json['image'],
        json['current_price'], json['price_change_percentage_24h']);
  }
}

List<Coin> coinList = [];
