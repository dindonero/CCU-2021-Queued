import 'package:Company/domain/store.dart';
import 'package:Company/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Stores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  Future<List<Store>> futureStores;
  final Store store = null;
  final Function press = null;

  @override
  void initState() {
    futureStores = getAllStores();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
                width: 380,
                height: 70,
                //color: Colors.white,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.store_mall_directory_sharp,
                          color: Colors.black, size: 45.0),
                    ),
                    Center(
                      child: Text(
                        "Nome Loja",
                        style: TextStyle(
                          color: Color(0xFF143656),
                          fontSize: 25,
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
