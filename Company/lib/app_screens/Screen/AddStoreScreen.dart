import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../domain/category.dart';
import '../../domain/category.dart';
import '../../dto/CategoryDto.dart';
import '../../dto/CategoryDto.dart';
import '../../dto/StoreDto.dart';
import '../../dto/StoreDto.dart';
import '../../services/ServerCommunicationService.dart';
import '../Widget/TextSearchWidget.dart';
import '../Widget/navBarWidget.dart';
import 'package:Company/dto/StoreDto.dart';

import 'AddStoreScreenNext.dart';

class AddStoreScreen extends StatefulWidget {
  @override
  _AddStoreScreenState createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  int storeCategory = 0;
  Future<List<Category>> futureCategories;
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );

  @override
  void initState() {
    futureCategories = ServerCommunicationService.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: SingleChildScrollView(
            child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenSize().height / 25),
            SizedBox(height: screenSize().height / 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("    Hello Maurício!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB2B2B2),
                      fontSize: 20)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
                    child: Text(" Store Name",
                        style: TextStyle(
                            color: Color(0xff13497b),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  )),
            ),
            SizedBox(height: screenSize().height / 30),
            Container(
              width: 380,
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: storeNameController,
                decoration: InputDecoration(
                    hintText: "Enter store name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    suffixIcon: Icon(Icons.library_add_check,
                        color: Color(0xff27192B0), size: 32.0)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
                    child: Text(" Store Address",
                        style: TextStyle(
                            color: Color(0xff13497b),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  )),
            ),
            SizedBox(height: screenSize().height / 30),
            Container(
              width: 380,
              child: TextFormField(
                controller: storeAddressController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "Enter store address",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    suffixIcon: Icon(Icons.library_add_check,
                        color: Color(0xff27192B0), size: 32.0)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
                    child: Text(" Store Category",
                        style: TextStyle(
                            color: Color(0xff13497b),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  )),
            ),
            SizedBox(height: screenSize().height / 30),
            Container(
              width: 380,
              child:
              Column(children: <Widget>[FutureBuilder<List<Category>>(future:this.futureCategories, builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                        child: SizedBox(
                            height: 70.0,
                            width: 70.0,
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Color(0xff22bec8)),
                                strokeWidth: 5.0)));
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                      return buildDropdownField(snapshot.data);
                }
              })]),
            ), //("Restaurant")
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
                    child: Text(" Store Image",
                        style: TextStyle(
                            color: Color(0xff13497b),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  )),
            ),
            SizedBox(height: screenSize().height / 30),
            Container(
              width: 60,
              height: 60,
              child: Icon(
                Icons.add_a_photo_rounded,
                color: Colors.white,
                size: 30,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff13497b),
              ),
            ),
            SizedBox(height: screenSize().height / 30),
            Container(
                width: screenSize().width / 1.2,
                height: screenSize().height / 15,
                child: RaisedButton(
                  color: Color(0xff13497B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddStoreScreenNext(store: StoreDto(name: this.storeNameController.text, address: this.storeAddressController.text, categoryId: this.storeCategory), )));
                  },
                  child: const Text('Next',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                )),
          ],
        )));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  DropdownButtonFormField buildDropdownField(List<Category> categories) {
    this.storeCategory = categories[0].id;
    var dropdownButtonFormField = DropdownButtonFormField(
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 45, right: 10, top: 20, bottom: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          filled: true,
          fillColor: Color(0xffF8FBFF)),
      value: this.storeCategory,
      onChanged: (int newValue) {
        setState(() {
          this.storeCategory = newValue;
        });
      },
      items: categories.map<DropdownMenuItem<int>>((Category category) {
        return DropdownMenuItem<int>(
          value: category.id,
          child: Text(category.title),
        );
      }).toList(),
    );
    return dropdownButtonFormField;
  }
}
