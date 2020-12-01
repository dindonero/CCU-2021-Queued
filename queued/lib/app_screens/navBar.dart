 import 'package:flutter/material.dart';
 
 
 Container navBar() {
    return Container( color: Colors.white, height:80 ,
      child: Row(children: [
         Spacer(),
        Icon(Icons.home_outlined, color: Color(0xff46D0D9), size: 50.0),
         Spacer(),
        Icon(Icons.location_on_outlined, color: Color(0xffCCD3DB), size: 50.0),
         Spacer(),
        Icon(Icons.confirmation_number_outlined  , color: Color(0xffCCD3DB), size: 50.0),
          Spacer(),
         Icon(Icons.person_outline  , color: Color(0xff13497B), size: 50.0),
          Spacer(),
      ],
    ),
    );
  }