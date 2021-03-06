import 'dart:math' as math;

import 'package:Staff/app_screens/Screen/StoreOffScreen.dart';
import 'package:Staff/app_screens/Widget/MainRowWidget.dart';
import 'package:Staff/app_screens/Widget/TextSearchWidget.dart';
import 'package:Staff/dto/CompanyAccountDto.dart';
import 'package:Staff/dto/StoreDto.dart';
import 'package:Staff/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widget/navBarWidget.dart';
import '../Card/StoresCard.dart';

class AllStaffStoresScreen extends StatefulWidget {
  Future<List<StoreDto>> futureStores;
  

  AllStaffStoresScreen();
  AllStaffStoresScreen.fromFutureStores(this.futureStores);

  @override
  _AllStaffStoresScreenState createState() => _AllStaffStoresScreenState.fromFutureStores(this.futureStores);
}

class _AllStaffStoresScreenState extends State<AllStaffStoresScreen> {
  CompanyAccountDto user = CompanyAccountDto(staffEmail: '');

  Future<List<StoreDto>> futureStores;

  _AllStaffStoresScreenState.fromFutureStores(this.futureStores);

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );

  @override
  void initState() {
    loadProfile().then((user) => futureStores = ServerCommunicationService.getAllStoresFromStaffEmail(user.staffEmail));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenSize().height / 15),
            MainRowWidget(),
            SizedBox(height: screenSize().height / 30),
            TextSearchField(),
            SizedBox(height: screenSize().height / 30),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSize().width / 25),
                  child: FutureBuilder<List<StoreDto>>(
                      future: this.futureStores,
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
                            else
                              return _buildGridView(context, snapshot.data);
                        }
                      })),
            ),
            Nav(0),
          ],
        ));
  }

  Widget _buildGridView(BuildContext context, List<StoreDto> stores) {
    return GridView.builder(
        itemCount: stores.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: screenSize().width / 20,
          crossAxisSpacing: screenSize().width / 25,
          childAspectRatio: 5,
        ),
        itemBuilder: (context, index) => StoresCard(
              store: stores[index],
               press: () => Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => StoreOff(
                       stores[index],null)
                     ),
                  )),
            );
  }

  Future<CompanyAccountDto> loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => user = CompanyAccountDto(
        id: prefs.getInt('id'),
        name: prefs.getString('name'),
        email: prefs.getString('email'),
        staffEmail: prefs.getString('staffEmail'),
        password: prefs.getString('password')));
    return user;
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}
