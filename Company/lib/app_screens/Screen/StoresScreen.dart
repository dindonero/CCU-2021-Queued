import 'dart:math' as math;

import 'package:Company/app_screens/Card/StoresCard.dart';
import 'package:Company/app_screens/Widget/TextSearchWidget.dart';
import 'package:Company/app_screens/Widget/navBarWidget.dart';
import 'package:Company/dto/CompanyAccountDto.dart';
import 'package:Company/dto/StoreDto.dart';
import 'package:Company/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  CompanyAccountDto user = CompanyAccountDto(name: '');
  Future<List<StoreDto>> stores;

  @override
  void initState() {
    loadProfile().then((user) => stores = ServerCommunicationService.getAllCompanyStores(user.id).then((value) { setState(() {}); return value;}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenSize().height / 25),
            SizedBox(height: screenSize().height / 40),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello " + user.name + "!",
                          style: TextStyle(
                              color: Color(0xFFB2B2B2), fontSize: 20)),
                      Text("These are your stores:",
                          style: TextStyle(
                              color: Color(0xFF143656), fontSize: 20)),
                    ],
                  ),
                ),
                Spacer(),
                Icon(Icons.notifications_none_outlined,
                    color: Color(0xff13497B), size: 32.0),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.settings_outlined,
                      color: Color(0xff13497B), size: 32.0),
                ),
              ],
            ),
            SizedBox(height: screenSize().height / 30),
            TextSearchField(),
            SizedBox(height: screenSize().height / 30),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 25),
                  child: FutureBuilder<List<StoreDto>>(
                      future: stores,
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
            Nav(0)
          ],
        ));
  }

  Widget _buildGridView(BuildContext context, List<StoreDto> stores) {
    return ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: StoresCards(stores[index], user.name)));
  }

  Future<CompanyAccountDto> loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => user = CompanyAccountDto(
        id: prefs.getInt('id'),
        name: prefs.getString('name'),
        email: prefs.getString('email'),
        password: prefs.getString('password')));
    return user;
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Row mainRow() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: Color(0xff13497B), size: 32.0),
        Text(" IST, Lisboa",
            style: TextStyle(color: Color(0xFF1143656), fontSize: 20)),
        Transform.rotate(
          angle: 90 * math.pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF143656),
            ),
            onPressed: null,
          ),
        ),
        Spacer(),
        Icon(Icons.notifications_none_outlined,
            color: Color(0xff13497B), size: 32.0),
        Icon(Icons.settings_outlined, color: Color(0xff13497B), size: 32.0),
      ],
    );
  }
}
