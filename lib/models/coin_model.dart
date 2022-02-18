// To parse this JSON data, do
//
//     final coin = coinFromJson(jsonString);

//import 'dart:convert';

// List<Coin> coinFromJson(String str) => List<Coin>.from(json.decode(str).map((x) => Coin.fromJson(x)));
//
// String coinToJson(List<Coin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coin {
  Coin( {
    required this.tokenAddress,
    required this.name,
    required this.symbol,
    this.logo,
    this.thumbnail,
    required this.decimals,
    required this.balance,
  });

  String tokenAddress;
  String name;
  String symbol;
  dynamic logo;
  dynamic thumbnail;
  String decimals;
  double balance;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
    tokenAddress: json["token_address"],
    name: json["name"],
    symbol: json["symbol"],
    logo: json["logo"],
    thumbnail: json["thumbnail"],
    decimals: json["decimals"],
    balance: json["balance"],
  );

  // Map<String, dynamic> toJson() => {
  //   "token_address": tokenAddress,
  //   "name": name,
  //   "symbol": symbol,
  //   "logo": logo,
  //   "thumbnail": thumbnail,
  //   "decimals": decimals,
  //   "balance": balance,
  // };
}
List<Coin> coinList = [];
