import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreatePin extends StatefulWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  _CreatePinState createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  bool isLogging = false;

  final _user = SharedPreferences.getInstance();
  getUserData() async {
    final data = await _user;
    setState(() {
      isLogging ? data.getBool('isLogging'): false;
    });
  }

  userLogin(bool isLogging) async {
    final user = await _user;
    setState(
      () {
        user.setBool('isLogging', isLogging);
      },
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const PassCode(),
      ),
    );
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
              value: isLogging,
              onChanged: (value) {
                setState(() {
                  isLogging = value;
                });
                userLogin(isLogging);
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class PassCode extends StatefulWidget {
  const PassCode({Key? key}) : super(key: key);
  @override
  _PassCodeState createState() => _PassCodeState();
}

class _PassCodeState extends State<PassCode> {
  TextEditingController pinText = TextEditingController();
  TextEditingController pinText2 = TextEditingController();
  bool isLogging = false;
  final _user = SharedPreferences.getInstance();
  String pin = '';
  String pin2 = '';

  login() async {
    final user = await _user;
    if (pin == pin2) {
      setState(() {
        user.setBool('isLogging', true);
        user.setString('pin', pin);
      });
      // print(pin);
      // print(user.getBool('isLogging'));
      // print(user.getString('pin'));
      Navigator.of(context).pop();
    }
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                heightFactor: MediaQuery.of(context).size.height / 200,
                child: const Text(
                  'Enter Your Passcode',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                height: MediaQuery.of(context).size.height / 15,
                child: PinCodeTextField(
                  appContext: context,
                  obscuringCharacter: '*',
                  length: 6,
                  controller: pinText,
                  obscureText: true,
                  autoFocus: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  autoDisposeControllers: false,
                  pinTheme: PinTheme(
                    selectedFillColor: Colors.white,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    borderWidth: 0,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (output) {
                    setState(() {
                      pin = pinText.text;
                    });
                  },
                ),
              ),
              Center(
                heightFactor: MediaQuery.of(context).size.height / 200,
                child: const Text(
                  'Re-Enter Your Passcode',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                height: MediaQuery.of(context).size.height / 15,
                child: PinCodeTextField(
                  appContext: context,
                  obscuringCharacter: '*',
                  length: 6,
                  controller: pinText2,
                  obscureText: true,
                  autoFocus: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  autoDisposeControllers: false,
                  pinTheme: PinTheme(
                    selectedFillColor: Colors.white,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    borderWidth: 0,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (output) {
                    setState(() {
                      pin2 = pinText2.text;
                    });
                    login();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
