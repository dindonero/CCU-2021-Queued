import 'package:Staff/dto/StoreDto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoreCard extends StatelessWidget {
  final StoreDto store;
  final Function press;

  const StoreCard({
    Key key,
    this.store,
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: store.img.image,
                    fit: BoxFit.cover,
                )),
                child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Center(
                      child: Text(
                        store.name,
                        style: TextStyle(
                          fontSize: 35,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 5
                            ..color = Colors.black,
                        ),
                      ),
                    ),
                    // solid text
                    Center(
                      child: Text(
                        store.name,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 35,
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
