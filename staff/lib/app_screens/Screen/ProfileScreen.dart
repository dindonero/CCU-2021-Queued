import 'dart:math' as math;
import 'package:Staff/app_screens/Screen/UserScreen/LoginScreen.dart';
import 'package:Staff/dto/CompanyAccountDto.dart';
import 'package:Staff/services/ServerCommunicationService.dart';
import 'package:Staff/app_screens/Screen/AllStaffStoresScreen.dart';
import 'package:Staff/app_screens/Screen/StoreOnScreen.dart';
import 'package:Staff/app_screens/Widget/navBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
   ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {  
  CompanyAccountDto user = CompanyAccountDto(staffEmail: '');
  _ProfileScreenState();

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
              Container( width: 350, child: Divider(thickness: 2, color: Color(0xFF676666),)),
              SizedBox(height: screenSize().height / 30),
              Container( alignment: Alignment.center,
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFF13497B),),
                                          color:  Color(0xFF13497B),
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
                child: Padding(padding:  EdgeInsets.symmetric(horizontal: screenSize().width / 5),
                        child: Row(children: [ 
                              Icon(Icons.notifications_outlined, color: Colors.white, size: 30,),
                              Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
               
                        ]),

                       ),
               ),
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
        Nav(1),
      ]),
    );
  }

  logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('name');
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
        Padding(padding:  EdgeInsets.only(left: screenSize().width / 25),
              child:  Padding(padding: EdgeInsets.only(right: screenSize().width / 80),
                      child:  Icon(Icons.account_circle_rounded,color: Color(0xFFBFBFBF),size: 80, ),
              ),
        ),
        Align(alignment: Alignment.centerLeft,
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Text('Staff               ',style: TextStyle(color: Color(0xFF000000),fontSize: 22, fontWeight: FontWeight.bold,),),
                      Text('View Account', style: TextStyle(color: Color(0xFF22BEC8),fontSize: 20,fontWeight: FontWeight.bold,),),
                ],),
         ),],
     );
   }
 
}
