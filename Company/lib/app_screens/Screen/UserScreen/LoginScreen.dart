import 'package:Company/app_screens/Screen/StoresScreen.dart';
import 'package:Company/dto/CompanyAccountDto.dart';
import 'package:Company/services/ServerCommunicationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignupScreen.dart';


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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize().height / 35),
                          child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Image.asset('images/logo_branco.png',
                                          width: 90),
                                      Text('UEUED'),
                                    ],
                                  ),
                                  Text('Company')
                                ],
                              )),
                      SizedBox(height: screenSize().height / 7),
                      Text("Welcome",
                          style: TextStyle(
                              color: Color(0xff13497b),
                              fontWeight: FontWeight.bold)),
                      Text("Login to help your clients wait online.",
                          style: TextStyle(
                              color: Color(0x50000000), fontSize: 22)),
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _showPassword=false;

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
                color:loginInfoAdded() ? Color(0xff13497B) : Color(0xaaaaaa),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  if (loginInfoAdded()) {
                    CompanyAccountDto newUserAccount = CompanyAccountDto(
                      email: emailController.text,
                      password: passwordController.text);
                    ServerCommunicationService.loginCompany(newUserAccount)
                        .then((user) => onLoginComplete(user))
                        .catchError((error) =>
                            onLoginError(error.toString()));
                  }
                },
                child: const Text('LOGIN',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ))
        ],
      ),
    );
  }

  bool loginInfoAdded() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  void onLoginComplete(CompanyAccountDto user) {
    storeLoggedInUser(user);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Stores()));
  }

  void onLoginError(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            title: Align(
              alignment: Alignment.center,
              child: Text(errorMessage),
            ),
            content: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 15,
                child: RaisedButton(
                  color: Color(0xff13497B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                )),
          );
        });
  }

  storeLoggedInUser(CompanyAccountDto user) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('id', user.id);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('password', user.password);
    prefs.setString('staffEmail', user.staffEmail);
     prefs.setString('staffPassword', user.staffPassword);
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "Enter your email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: Icon(Icons.email_outlined, color: Color(0xff22bec8)),
            ));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        controller: passwordController,
        obscureText: !this._showPassword,
        decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "Enter your password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye, 
              color: this._showPassword ? Color(0xff22bec8) : Colors.grey),
              onPressed: () {
                setState(() => this._showPassword = !this._showPassword);
            },)));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}
