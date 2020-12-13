import 'dart:math' as math;

import '../Screen/AddStoreScreenNext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountersCards extends StatelessWidget {

  final TextFormField counter;
  final Function(TextFormField) removeCounter;

 


  CountersCards(this.removeCounter,this.counter);

  @override
  Widget build(BuildContext context) {
     OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );
    return GestureDetector(
      child: Padding(
                padding: EdgeInsets.symmetric(
                horizontal: screenSize(context).width / 15), child:Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 290,
            height: 70,
            //color: Colors.white,
            child: counter),
          IconButton(icon: Icon(
                                Icons.remove_circle ,
                                color: Colors.red,
                                size: 30,
                                
                              ), onPressed:  () {
                  removeCounter(counter);
                },),
    ])));
  }  

   Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
