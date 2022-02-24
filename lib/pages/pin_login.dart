import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtoken_wallet/models/wallet_model.dart';
//import 'package:mtoken_wallet/utilities/wallet_database.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key,required this.wallet}) : super(key: key);
final Wallets? wallet;
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController pinText = TextEditingController();
  bool isLogging = false;
  bool isLoading = false;
  final _user = SharedPreferences.getInstance();

  String pin = '';
  String pin2 = '';
  userLogin() async {
    final user = await _user;
    setState(
      () {
        pin = user.getString('pin')!;
        isLogging = user.getBool('isLogging')!;
      },
    );
  }

  @override
  void initState() {
    userLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = widget.wallet;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                heightFactor: MediaQuery.of(context).size.height / 100,
                child: const Text(
                  'Enter Your Passcode',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                height: MediaQuery.of(context).size.height / 5,
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
                      pin2 = pinText.text;
                    });
                    if (pin == pin2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(
                            wallet: Wallets(
                                isCreated: wallet!.isCreated,
                                wallets: wallet.wallets,
                                private: wallet.private,
                                public: wallet.public,
                                phrase: wallet.phrase,
                                xpud: wallet.xpud),
                          ),
                        ),
                      );
                    }
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
