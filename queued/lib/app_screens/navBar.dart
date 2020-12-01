 import 'package:Queued/app_screens/categories.dart';
import 'package:flutter/material.dart';
 import 'queues.dart';


 Container navBar(context) {
    return Container( color: Colors.white, height:80 ,
      child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: <Widget>[
      IconButton(
        icon: Icon(Icons.home_outlined, color: Color(0xff46D0D9), size: 45.0),
        onPressed: () { Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Categories()));},//only static members can be accessed in initializers
      ),
      IconButton(
        icon: Icon(Icons.location_on_outlined, color: Color(0xffCCD3DB), size: 45.0),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.confirmation_number_outlined  , color: Color(0xffCCD3DB), size: 45.0),
        onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Queues()));},
      ),
      IconButton(
        icon: Icon(Icons.person_outline  , color: Color(0xff13497B), size: 45.0),
        onPressed: () {},
      ),
    ]
      ),
      );
  }

