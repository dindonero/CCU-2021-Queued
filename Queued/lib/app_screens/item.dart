import 'package:flutter/material.dart';
import 'category.dart';

class ItemCard extends StatelessWidget {
  final Category category;
  final Function press;
  const ItemCard({
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
          Expanded(
            child: Container(
              // padding: EdgeInsets.all(MediaQuery.of(context).size.height/10),
              // For  demo we use fixed height  and width
              // Now we dont need them
              height: 180,
              width: 160,
              child: Hero(
                tag: "${category.id}",
                child: Image.asset(category.image, width: 500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Text(
              // categorys is out demo list
              category.title,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}