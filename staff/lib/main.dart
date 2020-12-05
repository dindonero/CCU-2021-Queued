import 'package:flutter/material.dart';
import 'app_screens/Screen/StaffLoadingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staff',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff22bec8),
      ),
      home: StaffTheme(),
    );
  }
}