import 'package:Queued/app_screens/Screen/CategoriesScreen.dart';
import 'package:Queued/dto/UserAccountDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignupScreen.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenSize().height / 10),
                      Padding(
                          padding: EdgeInsets.symmetric( horizontal: 40,
                              vertical: screenSize().height / 50),
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
                      Text("Signup to start waiting online",
                          style: TextStyle(
                              color: Color(0x50000000), fontSize: 25)),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize().width / 10,
                              vertical: screenSize().width / 10),
                          child: SignForm()),
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
    return Column(
        children: [
          firstLastName(),
          SizedBox(height: screenSize().height / 20),
          buildEmailFormField(),
          SizedBox(height: screenSize().height / 20),
          buildPasswordFormField(),
          SizedBox(height: screenSize().height / 20),
          repeatPasswordFormField(),
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
                child: const Text('Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ))
        ],
    );
  }

TextFormField firstLastName() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "First and Last Name",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "Maria Joana",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.email_outlined, color: Color(0xff22bec8)),
            )),
            onChanged: saveEmail,);
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "email@gmail.com",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.email_outlined, color: Color(0xff22bec8)),
            )),
            onChanged: saveEmail,);
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "**********",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.lock_outline_rounded, color: Color(0xff22bec8)),
            )), 
            onChanged: savePassword,);
  }

  TextFormField repeatPasswordFormField() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Repeat Password",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "**********",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.lock_outline_rounded, color: Color(0xff22bec8)),
            )), 
            onChanged: savePassword,);
  }

  void saveEmail(String email){
      
  }

  void savePassword(String password){
      
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}
