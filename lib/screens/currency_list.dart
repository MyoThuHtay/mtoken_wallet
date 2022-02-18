// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../models/currencies_model.dart';

class CurrencyList extends StatefulWidget {
  const CurrencyList({
    Key? key,
  }) : super(key: key);

  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  int default_index = 0;
  String default_currency = 'usd';
  @override
  Widget build(BuildContext context) {
    List currencies = [
      'usd',
      'eur',
      'gbp',
      'hkd',
      'aud',
      'cad',
      'chf',
      'cny',
      'mmk',
      'inr',
      'jpy',
      'idr',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Currency'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            ListTile(
              title: Text(country[0]),
              trailing: Radio(
                toggleable: true,
                activeColor: Colors.blue,
                value: 0,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 0) {
                      default_index = 0;
                      default_currency = currencies[0];
                    }
                  });
                },
              ),
            ),
            ListTile(
              title: Text(country[1]),
              trailing: Radio(
                value: 1,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 1) {
                      default_index = 1;
                      default_currency = currencies[1];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[2]),
              trailing: Radio(
                value: 2,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 2) {
                      default_index = 2;
                      default_currency = currencies[2];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[3]),
              trailing: Radio(
                value: 3,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 3) {
                      default_index = 3;
                      default_currency = currencies[3];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[4]),
              trailing: Radio(
                value: 4,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 4) {
                      default_index = 4;
                      default_currency = currencies[4];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[5]),
              trailing: Radio(
                value: 5,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 5) {
                      default_index = 5;
                      default_currency = currencies[5];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[6]),
              trailing: Radio(
                value: 6,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 6) {
                      default_index = 6;
                      default_currency = currencies[6];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[7]),
              trailing: Radio(
                value: 7,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 7) {
                      default_index = 7;
                      default_currency = currencies[7];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[8]),
              trailing: Radio(
                value: 8,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 8) {
                      default_index = 8;
                      default_currency = currencies[8];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[9]),
              trailing: Radio(
                value: 9,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 9) {
                      default_index = 9;
                      default_currency = currencies[9];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[10]),
              trailing: Radio(
                value: 10,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 10) {
                      default_index = 10;
                      default_currency = currencies[10];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(country[11]),
              trailing: Radio(
                value: 11,
                groupValue: default_index,
                onChanged: (value) {
                  setState(() {
                    if (value == 11) {
                      default_index = 11;
                      default_currency = currencies[11];
                    }
                  });
                },
                toggleable: true,
                activeColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
