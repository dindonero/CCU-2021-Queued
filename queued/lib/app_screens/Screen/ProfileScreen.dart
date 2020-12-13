import 'dart:math' as math;
import 'package:Queued/app_screens/Screen/UserScreen/LoginScreen.dart';
import 'package:Queued/dto/UserAccountDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:Queued/app_screens/Widget/navBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserAccountDto user = UserAccountDto(firstName: '', lastName: '');

  @override
  void initState() {
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FBFF),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Expanded(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: screenSize().height / 15),
              mainRow(),
              Container(
                  width: 350,
                  child: Divider(
                    thickness: 2,
                    color: Color(0xFF676666),
                  )),
              SizedBox(height: screenSize().height / 30),
              Container(
                  width: 350,
                  height: 65,
                  child: RaisedButton(
                  color: Color(0xff13497B),
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onPressed: () {},
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.notifications_outlined, color: Color(0xFFFFFFFF), size: 40),
                    const Text(' Notifications',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
              ]))),
              SizedBox(height: screenSize().height / 30),
               Container(
                  width: 350,
                  height: 65,
                  child: RaisedButton(
                  color: Color(0xff13497B),
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onPressed: () {},
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.favorite_outline_rounded, color: Color(0xFFFFFFFF), size: 40),
                    const Text(' Favorites',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
              ]))),
              SizedBox(height: screenSize().height / 30),
              Container(
                width: 350,
                height: 65,
                child: RaisedButton(
                color: Color(0xffCC1F1F),
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: () {logoutUser();},
                child: Text('Log Out',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
            )),
            ],
          ),
        ),
        Nav(2),
      ]),
    );
  }

  loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = UserAccountDto(
          id: prefs.getInt('id'),
          firstName: prefs.getString('firstName'),
          lastName: prefs.getString('lastName'),
          email: prefs.getString('email'),
          password: prefs.getString('password'));
    });
  }

  logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('email');
    prefs.remove('password');
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Row mainRow() {
    return Row(
      children: [   
        Padding(padding:  EdgeInsets.only(left: screenSize().width / 25),
              child:  Padding(padding: EdgeInsets.only(right: 10),
                      child:  Icon(Icons.account_circle_rounded,color: Color(0xFFBFBFBF),size: 80, ),
              ),
        ),
        Align(alignment: Alignment.centerLeft,
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Text(user.firstName + " " + user.lastName,style: TextStyle(color: Color(0xFF000000),fontSize: 22, fontWeight: FontWeight.bold,),),
                      Text('View Account', style: TextStyle(color: Color(0xFF22BEC8),fontSize: 20,fontWeight: FontWeight.bold,),),
                ],),
         ),],
     );
  }
}
