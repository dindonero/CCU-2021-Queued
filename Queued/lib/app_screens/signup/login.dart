import 'package:Queued/app_screens/signup/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage("images/login_background.png"),
          fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 80)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Image.asset('images/logo_branco.png', width: 120),
              Text('UEUED')
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 150)),
          Text("Welcome", style: TextStyle(color: Color(0xff13497b), fontWeight: FontWeight.bold)),
          Text("Login to start waiting online.", style: TextStyle(color: Color(0x50000000), fontSize: 25)),
          InkWell(
            onTap: signup,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Haven't signed up yet? Click here", style: TextStyle(color: Color(0x50000000))),
            ),
          ),
        ])));
  }

  void signup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }
}
