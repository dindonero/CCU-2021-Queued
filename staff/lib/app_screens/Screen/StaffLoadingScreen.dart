import 'dart:async';

import 'package:flutter/material.dart';

import 'UserScreen/LoginScreen.dart';

class StaffTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 40, fontFamily: 'Rubik',
              fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
      home: StaffScreen()
    );
  }
}

class StaffScreen extends StatefulWidget {
  @override
  _StaffScreen createState() => _StaffScreen();
}

class _StaffScreen extends State<StaffScreen> {
  // This widget is the root of your application.
   @override
   void initState() {
     super.initState();
     Timer(Duration(seconds: 1), () => Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => LoginScreen())
     ));
   }

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: const Color(0xff22bec8),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Image.asset('images/logo_branco.png', width: 120),
                    Text('UEUED')
                  ],
                ),
                 Text('Staff')
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 100)
            ),
            SizedBox(
                height: 70.0,
                width: 70.0,
                child:
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 5.0)
            ),
            Padding(
                padding: EdgeInsets.only(top: 50)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text("wait "),
              Text("online,", style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            Padding(
                padding: EdgeInsets.only(top: 10)
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text(" not "),
                Text("inline.", style: TextStyle(fontWeight: FontWeight.bold))
            ])
          ])
    );
  }
}