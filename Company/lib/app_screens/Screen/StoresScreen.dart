import 'dart:math' as math;

import 'package:Company/app_screens/Card/StoresCard.dart';
import 'package:Company/app_screens/Widget/TextSearchWidget.dart';
import 'package:Company/app_screens/Widget/navBarWidget.dart';
import 'package:Company/dto/StoreDto.dart';
import 'package:Company/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';

class Stores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  //Future<List<StoreDto>> futureStores;
  Future<List<StoreDto>> futureStores;

  @override
  void initState() {
    futureStores = ServerCommunicationService.getAllCompanyStores(1);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenSize().height / 25),
            SizedBox(height: screenSize().height / 40),
            Row(
              children: [
                Padding(
                       padding:  EdgeInsets.only(left: 0),
                         child:
                Column(
                  children: [
                     Text("Hello Maurício!       ",
                          style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 20)),
                     Text("     These are your stores:",
                              style: TextStyle(color: Color(0xFF143656), fontSize: 20)),

                  ],
                ),),
                Spacer(),
                Icon(Icons.notifications_none_outlined,color: Color(0xff13497B), size: 32.0),
                  Padding(
                       padding:  EdgeInsets.only(right: 20),
                         child: Icon(Icons.settings_outlined, color: Color(0xff13497B), size: 32.0),),
              ],
            ),
            SizedBox(height: screenSize().height / 30),
            TextSearchField(),
            //
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
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
            Nav(0)
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
      itemBuilder: (context, index) => StoresCards(
            store: stores[index],
            press: () => null
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => Store(
          //           getTicket(stores[index]),
          //         ),
          //       )),
          ));
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
