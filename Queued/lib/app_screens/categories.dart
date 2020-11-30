import 'package:flutter/material.dart';
import 'category.dart';
import 'item.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FBFF),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisSpacing: screenSize().width/10,
                // crossAxisSpacing: screenSize().width/10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => ItemCard(
                    category: categories[index],
                    // press: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => DetailsScreen(
                    //         category: categories[index],
                    //       ),
                    //     )),
                  )),
        ),
      ),
      ],
    ));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

}