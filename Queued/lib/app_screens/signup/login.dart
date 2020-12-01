import 'package:Queued/app_screens/services/ServerCommunicationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../categories.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            reverse: true,
            child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/login_background2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize().height / 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Image.asset('images/logo_branco.png',
                                  width: 120),
                              Text('UEUED')
                            ],
                          )),
                      SizedBox(height: screenSize().height / 10),
                      Text("Welcome",
                          style: TextStyle(
                              color: Color(0xff13497b),
                              fontWeight: FontWeight.bold)),
                      Text("Login to start waiting online.",
                          style: TextStyle(
                              color: Color(0x50000000), fontSize: 25)),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize().width / 10,
                              vertical: screenSize().width / 10),
                          child: SignForm()),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: signup,
                              child: Text("Forgot password?",
                                  style: TextStyle(
                                      color: Color(0x50000000), fontSize: 18)),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize().width / 8)),
                            InkWell(
                              onTap: signup,
                              child: Text("Sign up",
                                  style: TextStyle(
                                      color: Color(0xff13497b), fontSize: 18)),
                            ),
                          ])
                    ])))));
  }

  void signup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: screenSize().height / 20),
          buildPasswordFormField(),
          SizedBox(height: screenSize().height / 20),
          Container(
              width: screenSize().width,
              height: screenSize().height / 15,
              child: RaisedButton(
                color: Color(0xff13497B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Categories()));
                },
                child: const Text('LOGIN',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ))
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "Enter your email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.email_outlined, color: Color(0xff22bec8)),
            )));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "Enter your password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.lock_outline_rounded, color: Color(0xff22bec8)),
            )));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}
