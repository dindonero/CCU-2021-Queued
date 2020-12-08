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
      body: Column(children: <Widget>[
        Expanded(
          child: Column(
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
                alignment: Alignment.center,
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF13497B),
                  ),
                  color: Color(0xFF13497B),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize().width / 5),
                  child: Row(children: [
                    Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      ' Notifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(height: screenSize().height / 30),
              Container(
                alignment: Alignment.center,
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF13497B),
                  ),
                  color: Color(0xFF13497B),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize().width / 4),
                  child: Row(children: [
                    Icon(
                      Icons.favorite_outline_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      ' Favorites',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
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
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenSize().width / 25),
          child: Padding(
            padding: EdgeInsets.only(right: 0),
            child: Icon(
              Icons.account_circle_rounded,
              color: Color(0xFFBFBFBF),
              size: 80,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                user.firstName + " " + user.lastName,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(children: [
                Text(
                  '      View Account',
                  style: TextStyle(
                    color: Color(0xFF22BEC8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: screenSize().width / 15),
                InkWell(
                  onTap: () => logoutUser(),
                  child: Text("Logout",
                      style: TextStyle(
                        color: Color(0xFF22BEC8),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ])
            ],
          ),
        ),
      ],
    );
  }
}
