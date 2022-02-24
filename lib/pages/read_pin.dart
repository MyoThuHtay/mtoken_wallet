import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_pin.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  _CreatePinState createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  bool? isLogging = false;
  bool isLogging2 = false;

  final _user = SharedPreferences.getInstance();
  getUserData() async {
    final data = await _user;
    isLogging = data.getBool('isLogging');
    if (isLogging != null) {
      setState(() {
        isLogging2 = isLogging!;
      });
    }
    if (kDebugMode) {
      print(isLogging2.toString());
    }
  }

  userLogin(bool? isLogging) async {
    final user = await _user;
    setState(
      () {
        user.setBool('isLogging', isLogging!);
      },
    );
if (kDebugMode) {
  print(user.getBool('isLogging'));
}
isLogging2?
Navigator.of(context).pushReplacement(
  MaterialPageRoute(
    builder: (context) => const PassCode(),
  ),
)
    :Navigator.of(context).pop();

  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Security',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          ListTile(
            title: const Text('PassCode'),
            trailing: Switch.adaptive(
              value: isLogging2,
              onChanged: (value) {
                setState(() {
                  isLogging2 = value;
                });
                userLogin(isLogging2);
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

