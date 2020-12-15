import 'package:Queued/app_screens/Screen/CategoriesScreen.dart';
import 'package:Queued/dto/UserAccountDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
            reverse: false,
            child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/login_background3.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Padding(
                          padding: EdgeInsets.symmetric( horizontal: 50,
                              vertical: screenSize().height / 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Image.asset('images/logo_branco.png',
                                  width: 120),
                              Text('UEUED')
                            ],
                          )),
                          SizedBox(height: screenSize().height / 20),
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

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

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
                  if ( firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty && repeatPasswordController.text.isNotEmpty &&  repeatPasswordController.text == passwordController.text){
                    UserAccountDto newUserAccount =  UserAccountDto(firstName: firstNameController.text, lastName: lastNameController.text, email: emailController.text, password:passwordController.text);
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

  void onSignUpComplete(UserAccountDto user) {
    storeLoggedInUser(user);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Categories()));
  }

  void onSignUpError(String errorMessage) {
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

  storeLoggedInUser(UserAccountDto user) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('id', user.id);
    prefs.setString('firstName', user.firstName);
    prefs.setString('lastName', user.lastName);
    prefs.setString('email', user.email);
    prefs.setString('password', user.password);
  }

TextFormField buildFirstName() {
    return TextFormField(
      controller: firstNameController,
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
            )),);
  }

TextFormField buildLastName() {
    return TextFormField(
      controller: lastNameController,
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
            )),);
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
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
            )),);
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
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
            )),);
  }

  TextFormField repeatPasswordFormField() {
    return TextFormField(
      controller: repeatPasswordController,
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
            )),);
  }


  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}
