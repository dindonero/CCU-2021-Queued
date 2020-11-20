import 'package:ccu_app/app_screens/signup/signup.dart';
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
        backgroundColor: const Color(0xff22bec8),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                      height: 1))
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 100)),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text("wait ",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                      height: 1)),
              Text("online,",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 1)),
            ]),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(" not ",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                      height: 1)),
              Text("inline.",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 1)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(" Click here to sign up -> ",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      height: 1)),
              Container(
                  padding: EdgeInsets.all(0),
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.centerRight,
                    icon: (Icon(Icons.star)),
                    color: Colors.red[500],
                    onPressed: signup,
                  )),
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: signup,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Haven't signed up yet? Click here"),
                    ),
                  ),
                ])
          ])
        ]));
  }

  void signup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }
}
