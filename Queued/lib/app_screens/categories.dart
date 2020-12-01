import 'package:flutter/material.dart';
import 'category.dart';
import 'item.dart';
import 'navBar.dart';
import 'dart:math' as math;


class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FBFF),
      body: Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          SizedBox(height: screenSize().height/25),
           Align(alignment: Alignment.center,
           child: Padding(padding: const EdgeInsets.all(20.0),
              child:mainRow(),
              ),
           ),
          SizedBox(height: screenSize().height/40),
          Align(alignment: Alignment.centerLeft,
                child: Text("    Hello Maurício!", style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 20)),
          ),
          Align(alignment: Alignment.centerLeft,
                child: Text("    Please choose your category", style: TextStyle(color: Color(0xFF143656), fontSize: 20)),
          ),
          SizedBox(height: screenSize().height/30),
          Container(width: 380,
              child: buildSearchField(),
              ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisSpacing: screenSize().width/10,
                // crossAxisSpacing: screenSize().width/10,
                childAspectRatio: 0.9,
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
      navBar(),
      ],
    ));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

    TextFormField buildSearchField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
      hintText: "What are you looking for?",
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      prefixIcon:Padding( padding: EdgeInsets.symmetric(horizontal: 27),
          child: Icon(Icons.search, color: Color(0xff27192B0), size: 32.0),
      )
      )
    );
  }

  Row mainRow() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: Color(0xff13497B), size: 32.0),
        Text(" IST, Lisboa", style: TextStyle(color: Color(0xFF1143656), fontSize: 20)),
        Transform.rotate(
            angle: 90 * math.pi / 180,
            child: IconButton(
            icon: Icon(Icons.arrow_forward_ios_rounded,color: Color(0xFF143656),), onPressed: null,),
            ),
         Spacer(),
         Icon(Icons.notifications_none_outlined , color: Color(0xff13497B), size: 32.0),
         Icon(Icons.settings_outlined , color: Color(0xff13497B), size: 32.0),
      ],
    );
  }



}