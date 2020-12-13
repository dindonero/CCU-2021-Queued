import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:Company/dto/StoreDto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/category.dart';
import '../../dto/StoreDto.dart';
import '../../services/ServerCommunicationService.dart';
import 'AddStoreScreenNext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Company/dto/CompanyAccountDto.dart';

class AddStoreScreen extends StatefulWidget {
  AddStoreScreen();

  @override
  _AddStoreScreenState createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  int storeCategory;
  Future<List<Category>> futureCategories;
  Uint8List _image;
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );

  _AddStoreScreenState();

  CompanyAccountDto user = CompanyAccountDto(name: '');


  @override
  void initState() {
    futureCategories = ServerCommunicationService.getAllCategories();
    loadProfile();
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
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF143656),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Text(user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF13497B),
                              fontSize: 30)),
                      Container(
                        width: 50,
                      ),
                    ],
                  ),
                  Container(
                    width: 360,
                    child: Divider(
                      height: 20,
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
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
              child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25), child:TextFormField(
                keyboardType: TextInputType.name,
                controller: storeNameController,
                decoration: InputDecoration(
                    hintText: "Enter store name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    suffixIcon: Icon(Icons.check_circle_rounded,
                        color: storeNameController.text.isNotEmpty ? Color(0xff1EA9B4) : Color(0xaaaaaa), size: 28)),
              ))),
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
              child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25), child: TextFormField(
                controller: storeAddressController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "Enter store address",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    suffixIcon: Icon(Icons.check_circle_rounded,
                        color: storeAddressController.text.isNotEmpty ? Color(0xff1EA9B4) : Color(0xaaaaaa), size: 28)),
              ),
            )),
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
              child: Column(children: <Widget>[
                FutureBuilder<List<Category>>(
                    future: this.futureCategories,
                    builder: (context, snapshot) {
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
                          else {
                            return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize().width / 25), child: buildDropdownField(snapshot.data));
                          }
                      }
                    })
              ]),
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
            GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: _image == null
                    ? Container(
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
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: Image.memory(_image).image,
                          fit: BoxFit.cover,
                        )))),
            SizedBox(height: screenSize().height / 30),
            Container(
                width: screenSize().width / 1.2,
                height: screenSize().height / 15,
                child: allInserted()
                    ? nextButtonReady()
                    : nextButtonAwaitingInput()),
            SizedBox(height: screenSize().height / 30),
          ],
        )));
  }

  loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = CompanyAccountDto(
          id: prefs.getInt('id'),
          name: prefs.getString('name'),
          email: prefs.getString('email'),
          password: prefs.getString('password'));
      });
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  RaisedButton nextButtonReady() {
    return RaisedButton(
      color: Color(0xff13497B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddStoreScreenNext(
                      StoreDto(
                          name: this.storeNameController.text,
                          address: this.storeAddressController.text,
                          categoryId: this.storeCategory,
                          imageBytes: _image),
                       user.name)));
      },
      child: const Text('Next',
          style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  RaisedButton nextButtonAwaitingInput() {
    return RaisedButton(
      color: Color(0xaaaaaa),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {},
      child: const Text('Next',
          style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  DropdownButtonFormField buildDropdownField(List<Category> categories) {
    var dropdownButtonFormField = DropdownButtonFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          filled: true,
          fillColor: Color(0xffF8FBFF)),
      hint: Text("Select Category"),
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

  bool allInserted() {
    return storeNameController.text.isNotEmpty &&
        storeAddressController.text.isNotEmpty &&
        _image != null && storeCategory != null;
  }

  //todo change to account for exception of user not taking photo
  _imgFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    Uint8List imageBytes = await image.readAsBytes();

    setState(() {
      _image = imageBytes;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    Uint8List imageBytes = await image.readAsBytes();
    setState(() {
      _image = imageBytes;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
