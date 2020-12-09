import 'dart:math' as math;

import 'package:Queued/app_screens/Widget/MainRowWidget.dart';
import 'package:Queued/dto/StoreDto.dart';
import 'package:Queued/dto/CounterDto.dart';
import 'package:Queued/app_screens/Widget/navBarWidget.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'StoresListScreen.dart';
import 'TicketScreen.dart';

class Store extends StatefulWidget {
  final StoreDto store;
  final CounterDto counter;

  Store(this.store, this.counter);

  //Stores({Key key, @required this.id}) : super(key: key);
  @override
  _StoreState createState() => _StoreState(this.store, this.counter);
}

class _StoreState extends State<Store> {
  String name;
  Image img;
  final StoreDto store;
  CounterDto counter;

  _StoreState(this.store, this.counter);

  @override
  void initState() {
    name = this.store.name;
    img = this.store.img;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: Column( children: <Widget>[Expanded(child: SingleChildScrollView(
            reverse: false,
            child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: screenSize().height / 25),
                    MainRowWidget(),
                    Container(
                        height: (screenSize().width / 3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: img.image, fit: BoxFit.cover)),
                        child: Stack(
                          children: <Widget>[
                            // Stroked text as border.
                            Center(
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
                            // solid text
                            Center(
                              child: Text(
                                name,
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 35,
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: screenSize().height / 50),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize().width / 25),
                      child: secondRow(),
                    ),
                    SizedBox(height: screenSize().height / 30),
                    aheadRow(),
                    estimatedWaitingTimeRow(),
                    SizedBox(height: screenSize().height / 15),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize().width / 5),
                      child: getTicketButton(),
                    ),
                    SizedBox(height: screenSize().height / 35),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize().width / 5),
                      child: getDailyPredictionsButton(),
                    ),
                  ],
                )))),
                ]));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Row secondRow() {
    return Row(
      children: [
        Icon(Icons.access_time_rounded, color: Color(0xFF000000), size: 32.0),
        Text(
            formatSchedule(this.store.schedules[0].openingTime) +
                " - " +
                formatSchedule(this.store.schedules[0].closingTime),
            style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        //Text(currentCounter.,style: TextStyle(color: Color(0xFF000000), fontSize: 20))
        Spacer(),
        RaisedButton(onPressed: () => openMaps(),
        child: Row(children: [
          Icon(Icons.location_on_outlined, color: Color(0xFF000000), size: 32.0),
          Text(" Directions", style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        ],))
      ],
    );
  }

  Future<void> openMaps() async{
    String url = "https://www.google.com/maps/search/?api=1&query=" + store.address.replaceAll(" ", "+");
    print("launching = " + url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Row aheadRow() {
    return Row(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize().width / 10),
          child: Icon(Icons.people_alt, color: Color(0xFF000000), size: 60.0),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ahead: ",
              style: TextStyle(
                  color: Color(0xFF143656),
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Text(
              this.counter.peopleWaitingInLine.toString() + " people",
              style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        ],
      ),
    ]);
  }

  Row estimatedWaitingTimeRow() {
    return Row(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize().width / 10),
          child: Icon(Icons.access_time_rounded,
              color: Color(0xFF000000), size: 60.0),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Estimated waiting time:",
              style: TextStyle(
                  color: Color(0xFF143656),
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          Text(
              (this.counter.avgWaitingTime.hour * 60 +
                          this.counter.avgWaitingTime.minute)
                      .toString() +
                  " minutes",
              style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        ],
      ),
    ]);
  }

  Container getTicketButton() {
    return Container(
        width: screenSize().width,
        height: screenSize().height / 10,
        child: RaisedButton(
          color: Color(0xff13497B),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Ticket(
                        ServerCommunicationService.getNewUserTicket(1, this.counter.id)))); // todo userid and counterId
          },
          child: const Text('Get Ticket',
              style: TextStyle(fontSize: 25, color: Colors.white)),
        ));
  }

  Container getDailyPredictionsButton() {
    return Container(
        width: screenSize().width,
        height: screenSize().height / 10,
        child: RaisedButton(
          color: Color(0xff13497B),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {},
          child: const Text('Daily Predictions',
              style: TextStyle(fontSize: 25, color: Colors.white)),
        ));
  }
}

String formatSchedule(DateTime time) {
  String sTime;
  if (time.hour < 10)
    sTime = "0" + time.hour.toString();
  else
    sTime = time.hour.toString();
  sTime += ":";
  if (time.minute < 10)
    sTime += "0" + time.minute.toString();
  else
    sTime = time.minute.toString();
  return sTime;
}
