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
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Transform.rotate(
              angle: 180 * math.pi / 180,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF143656),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Spacer(),
            Icon(Icons.location_on_outlined, color: Color(0xff13497B), size: 32.0),
            Text(" IST, Lisboa",
                style: TextStyle(color: Color(0xFF1143656), fontSize: 20)),
            Transform.rotate(
              angle: 90 * math.pi / 180,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF143656),
                ),
                onPressed: null,
              ),
            ),
            Spacer(),
            Icon(Icons.notifications_none_outlined,
                color: Color(0xff13497B), size: 32.0),
            Icon(Icons.settings_outlined, color: Color(0xff13497B), size: 32.0),
          ],
        ),
      ),
    );
  }
}

