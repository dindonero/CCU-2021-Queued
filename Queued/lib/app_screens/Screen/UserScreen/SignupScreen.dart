import 'package:Queued/app_screens/Screen/CategoriesScreen.dart';
import 'package:Queued/dto/UserAccountDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  String error;
  String passError;

  SignUpScreen(this.error, this.passError);

  @override
  _SignUpScreen createState() => _SignUpScreen(this.error, this.passError);
}

class _SignUpScreen extends State<SignUpScreen> {
  // This widget is the root of your application.
final String error;
final String passError;


_SignUpScreen(this.error, this.passError);


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
                          padding: EdgeInsets.symmetric( horizontal: 50,
                              vertical: screenSize().height / 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Image.asset('images/logo_branco.png',
                                  width: 120),
                              Text('UEUED')
                            ],
                          )),
                      Text("Welcome",
                          style: TextStyle(
                              color: Color(0xff13497b),
                              fontWeight: FontWeight.bold)),
                      Text('Signup to start waiting online',
                          style: TextStyle(
                              color: Color(0x50000000), fontSize: 25)),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize().width / 10,
                              vertical: screenSize().width / 10),
                          child: SignForm(this.error, this.passError)),
                    ])))));
  }

  

  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}

class SignForm extends StatefulWidget {
  final String error;
  final String passError;

  SignForm(this.error, this.passError);

  @override
  _SignFormState createState() => _SignFormState(this.error, this.passError);
}

class _SignFormState extends State<SignForm> {
  final String error;
  final String passError;

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );

  String firstName;
  String lastName;
  String email;
  String password;
  String repeatPassword;

  _SignFormState(this.error, this.passError);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          buildFirstName(),
          SizedBox(height: screenSize().height / 30),
          buildLastName(),
          SizedBox(height: screenSize().height / 30),
          buildEmailFormField(),
          SizedBox(height: screenSize().height / 30),
          buildPasswordFormField(),
          SizedBox(height: screenSize().height / 30),
          repeatPasswordFormField(),
          SizedBox(height: screenSize().height / 30),
          Container(
              width: screenSize().width,
              height: screenSize().height / 15,
              child: RaisedButton(
                color: Color(0xff13497B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  if ( repeatPassword == password){
                    UserAccountDto newUserAccount =  UserAccountDto(firstName: firstName, lastName: lastName, email: email, password:password);
                    ServerCommunicationService.createNewUserAccount(newUserAccount).then((user) => onSignUpComplete(user)).catchError((error) => onSignUpError(error));
                  }else{
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpScreen(null,'Password needs to be the same!')));
                  }
                },
                child: const Text('Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ))
        ],
    );
  }

void onSignUpComplete(int userIndex){
   Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Categories()));
}

void onSignUpError(Exception user){
  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpScreen('An account already exist with this email', null)));
}

TextFormField buildFirstName() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "First Name",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "Insert first name",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.email_outlined, color: Color(0xff22bec8)),
            )),
            onChanged: saveFirstName,);
  }

TextFormField buildLastName() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "Last Name",
            labelStyle: TextStyle(fontSize: 20),
            hintText: "Insert last name",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.email_outlined, color: Color(0xff22bec8)),
            )),
            onChanged: saveLastName,);
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
            errorText: this.error,
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
            errorText: this.passError,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.lock_outline_rounded, color: Color(0xff22bec8)),
            )), 
            onChanged: saveRepeatPassword,);
  }

  void saveFirstName(String name){
      firstName = name;
  }

   void saveLastName(String name){
      lastName = name;
  }

  void saveEmail(String mail){
      email = mail;
  }

  void savePassword(String pass){
      password = pass;
  }

  void saveRepeatPassword(String pass){
      repeatPassword = pass;
  }


  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}
