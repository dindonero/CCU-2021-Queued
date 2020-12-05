import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CounterCard extends StatelessWidget {
  final String name;
  final Function press;

  const CounterCard({
    Key key,
    this.name,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Center(
          child: Container(
        width: 380,
        height: 70,
        //color: Colors.white,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: Color(0xFF143656),
              fontSize: 25,
            ),
          ),
        ),
      )
          // padding: EdgeInsets.all(MediaQuery.of(context).size.height/10),
          // For  demo we use fixed height  and width
          // Now we dont need them
          ),
    );
  }
}
