//import 'package:flutter/material.dart';
//import 'package:mtoken_wallet/pages/pin_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../home.dart';

class Control {
  static final Control instance = Control._init();
  static SharedPreferences? _user;
  Control._init();

  Future<SharedPreferences?> get user async {
    if (_user != null) return _user!;
    final user = _user;
    return user;
  }

  Future<SharedPreferences?> login() async {
    final user = await instance.user;
    bool? isLogging = user?.getBool('isLogging');
    if (isLogging == true) {
      return login();
    } else {
      return this.user;
    }
  }
}
