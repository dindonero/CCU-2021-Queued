import 'package:Company/app_screens/Screen/StoresListScreen.dart';
import 'package:Company/dto/StoreDto.dart';
import 'package:Company/services/ServerCommunicationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSearchField extends StatefulWidget {
  @override
  _TextSearchField createState() => _TextSearchField();
}

class _TextSearchField extends State<TextSearchField> {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );
  //TextEditingController textInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 25),
        child: TextFormField(
          //controller: textInput,
          onFieldSubmitted: searchStoresQuery,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "What are you looking for?",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child:
                      Icon(Icons.search, color: Color(0xff27192B0), size: 32.0),
                ))));
  }

  void searchStoresQuery(String query){
    Future<List<StoreDto>> stores = ServerCommunicationService.findStoresByName(query);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Stores.fromFutureStores(stores)));
  }
}