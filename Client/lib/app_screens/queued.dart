import 'package:flutter/material.dart';
import 'dart:async';

class QueuedScreen extends StatefulWidget {
  @override
  _QueuedScreen createState() => _QueuedScreen();
}

class _QueuedScreen extends State<QueuedScreen> {
  // This widget is the root of your application.
   @override
   void initState() {
     super.initState();
     Timer(Duration(seconds: 5), ()=> print("Splash Done!"));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QueuedImageAsset(),
                  Text('UEUED', textAlign: TextAlign.left, style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ))
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 100)
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    Text("wait ", style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                          height: 1
                      )),
                    Text("online,", style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Rubik',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 1))
                  ]),
                  Padding(
                      padding: EdgeInsets.only(top: 10)
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Text(" not ", style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                          height: 1
                      )),
                      Text("inline.", style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          height: 1))
                      ])
                    ])
              ])
    );
  }
}

class QueuedImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Image image = new Image.asset('images/logo_branco.png', width: 120);
    return Container(child: image,);
  }
}