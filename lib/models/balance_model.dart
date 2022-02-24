// To parse this JSON data, do
//
//     final balance = balanceFromJson(jsonString);

import 'dart:convert';

Balance balanceFromJson(String str) => Balance.fromJson(json.decode(str));

//String balanceToJson(Balance data) => json.encode(data.toJson());

class Balance {
  Balance({
    required this.result,
  });

  String result;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        result: json["result"],
      );
}
