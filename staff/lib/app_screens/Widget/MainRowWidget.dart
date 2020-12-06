import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainRowWidget extends StatefulWidget {
  @override
  _MainRowWidget createState() => _MainRowWidget();
}

class _MainRowWidget extends State<MainRowWidget>{

  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
                    child: Row(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Hello Staff!",
                  style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 20)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Select a store:",
                  style: TextStyle(color: Color(0xFF143656), fontSize: 20)),
            ),
        ],),
        Spacer(),
        Icon(Icons.notifications_none_outlined,
            color: Color(0xff13497B), size: 32.0),
        Icon(Icons.settings_outlined, color: Color(0xff13497B), size: 32.0),
      ],
    ),

              ),),);
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}

