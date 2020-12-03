import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../domain/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final Function press;
  const CategoryCard({
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
              width: 800,
              decoration: BoxDecoration(
                    image: DecorationImage(
                        image: category.image.image,
                        fit: BoxFit.cover
                    )
              ),
              child: Stack(
                children: <Widget>[
                    // Stroked text as border.
                    Center( child: Text(
                                          category.title,
                                          style: TextStyle(
                                              fontSize: 25,
                                              foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 5
                                              ..color = Colors.black,
                                          ),
                                        ),
                          ),
                    // solid text
                    Center (child:  Text(category.title, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 25, ),),),
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