import 'dart:math' as math;

import 'package:Staff/app_screens/Card/CounterCard.dart';
import 'package:Staff/app_screens/Widget/MainRowWidget.dart';
import 'package:Staff/dto/CounterDto.dart';
import 'package:Staff/dto/StoreDto.dart';
import 'package:flutter/material.dart';

import 'StoreScreen.dart';

class SelectQ extends StatefulWidget {
  final StoreDto store;

  SelectQ(this.store);

  //Stores({Key key, @required this.id}) : super(key: key);
  @override
  _SelectQState createState() => _SelectQState(this.store);
}

class _SelectQState extends State<SelectQ> {
  String name;
  Image img;
  final StoreDto store;
  Future<List<CounterDto>> futureStores;

  _SelectQState(this.store);

  @override
  void initState() {
    name = this.store.name;
    img = this.store.img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        body: Column(
          children: <Widget>[
            SizedBox(height: screenSize().height / 25),
            MainRowWidget(),
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize().height / 50),
                  Container(
                      width: 900,
                      height: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: img.image, fit: BoxFit.cover)),
                      child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 35,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 5
                                      ..color = Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // solid text
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: screenSize().height / 20),
                  Container(
                      width: 350,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xFF13497B),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize().width / 10,
                                  vertical: screenSize().width / 15),
                              child: Text(
                                "Select Queue:",
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1),
                                child: FutureBuilder<List<CounterDto>>(
                                    future: this.futureStores,
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return CircularProgressIndicator();
                                        default:
                                          if (snapshot.hasError)
                                            return new Text(
                                                'Error: ${snapshot.error}');
                                          else
                                            return _buildGridView(
                                                context, snapshot.data);
                                      }
                                    })),
                          ),
                        ],
                      )),
                  // getTicketButton(),
                  //SizedBox(height: screenSize().height / 35),
                  //getDailyPredictionsButton(),
                  Spacer(),
                ],
              ),
            ),
          ],
        ));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Container getTicketButton() {
    return Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
          color: Color(0xFF718EA9),
          border: Border.all(
            color: Color(0xFF13497B),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize().width / 10),
          child: Text("Get Ticket",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Container getDailyPredictionsButton() {
    return Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
          color: Color(0xFF718EA9),
          border: Border.all(
            color: Color(0xFF13497B),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize().width / 10),
          child: Text("Daily Predictions",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildGridView(BuildContext context, List<CounterDto> counters) {
    return GridView.builder(
        itemCount: counters.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          // mainAxisSpacing: screenSize().width /20,
          // crossAxisSpacing: screenSize().width / 30,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) => CounterCard(
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Store(store),
                  )),
            ));
  }
}
