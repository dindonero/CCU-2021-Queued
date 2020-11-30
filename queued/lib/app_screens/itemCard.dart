import 'package:flutter/material.dart';
import 'products.dart';

class ItemCard extends StatelessWidget {
  final Category category;
  const ItemCard({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${category.id}",
                child: Image.asset(category.image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}