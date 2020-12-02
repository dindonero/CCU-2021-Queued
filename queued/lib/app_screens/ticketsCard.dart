import 'package:Queued/domain/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class TicketsCard extends StatelessWidget {
  final Category category;
  final Function press;

  const TicketsCard({
    Key key,
    this.category,
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
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Transform.rotate(
                        angle: 225 * math.pi / 180,
                        child: Icon(Icons.confirmation_number_outlined,
                            color: Colors.black, size: 45.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        category.title,
                        style: TextStyle(
                          color: Color(0xFF143656),
                          fontSize: 25,
                        ),
                      ),
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
}
