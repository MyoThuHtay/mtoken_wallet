import 'package:flutter/material.dart';
import 'package:mtoken_wallet/models/coin_model.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
//import '../models/coinlist_model.dart';
import 'dart:convert';
import 'dart:async';

import '../theme_provider.dart';

class CoinList extends StatefulWidget {
  const CoinList({Key? key}) : super(key: key);

  @override
  _CoinListState createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  final myController = TextEditingController();
  String data = '';
  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please Enter Valid Name'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      },
    );
  }

  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    //final String cid = fetchCurrency();
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

  addValue() {
    if (myController.text == '') {
      showAlert(context);
    } else {
      //return web;
      setState(() {
        data = myController.text;
      });
      //print(data);
    }
  }

  @override
  void initState() {
    fetchCoin();
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: TextFormField(
            showCursor: true,
            cursorColor: Colors.black38,
            controller: myController,
            enableSuggestions: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '  Search Tokens',
              suffixIcon: TextButton(
                  onPressed: () {
                    //_launchURL(myController.text);
                  },
                  child: Text(
                    'Go',
                    style: TextStyle(
                        color: Theme.of(context).iconTheme.color, fontSize: 20),
                  )),
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: coinList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              tileColor: Theme.of(context).primaryColor,
              leading: const Icon(
                Icons.add_circle_outline_sharp,
                size: 40,
                color: Colors.blue,
              ),
              title: const Text('Add Custom Token'),
              onTap: (){},
            );
          }
          index -= 1;
          return ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundColor: Theme.of(context).indicatorColor,
              backgroundImage: NetworkImage(coinList[index].logo),
            ),
            title: Text(coinList[index].name),
            trailing: Switch.adaptive(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                final provider =
                Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(value);
              },
            ),
          );
        },
      ),
    );
  }
}
