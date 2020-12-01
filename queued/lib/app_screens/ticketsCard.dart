import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'category.dart';

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
      
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Center ( child: Container(
              width: 350,
              height: 80,
              //color: Colors.white,
              decoration: BoxDecoration(
    border: Border.all(color: Colors.black),color: Colors.white,
  ),
              child: Stack(
                children: <Widget>[
                    Icon(Icons.confirmation_number_outlined  , color: Colors.black, size: 45.0),
                    Center (child:  Text(category.title, style: TextStyle(color: Colors.black, fontSize: 25, ),),),
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