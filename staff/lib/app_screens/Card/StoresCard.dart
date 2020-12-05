import 'dart:math' as math;

import 'package:Staff/dto/StoreDto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoresCard extends StatelessWidget {
  final StoreDto store;
  final Function press;

  const StoresCard({
    Key key,
    this.store,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
                width: 380,
                height: 70,
                //color: Colors.white,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize(context).width / 25), 
                    child:  Icon(Icons.store_outlined,
                            color: Colors.black, size: 45.0),
                  )
                    ),
                    Align(     alignment: Alignment.centerRight,
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                       horizontal: screenSize(context).width / 25), 
                      child: Text(
                        store.name,
                        // category.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF143656),
                          fontSize: 25,
                        ),
                      ),
                  )
                      
                      
                
                    ),
                  ],
                )
                // padding: EdgeInsets.all(MediaQuery.of(context).size.height/10),
                // For  demo we use fixed height  and width
                // Now we dont need them

                ),
          ),
        ],
      ),
    );
  }

  Size screenSize(context) {
    return MediaQuery.of(context).size;
  }
}
