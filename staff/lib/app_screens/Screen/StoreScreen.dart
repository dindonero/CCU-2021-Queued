import 'dart:math' as math;

import 'package:Staff/app_screens/Screen/AllStaffStoresScreen.dart';
import 'package:Staff/app_screens/Widget/navBarWidget.dart';
import 'package:Staff/dto/StoreDto.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Store extends StatefulWidget {
  final StoreDto store;

  Store(this.store);

  //Stores({Key key, @required this.id}) : super(key: key);
  @override
  _StoreState createState() => _StoreState(this.store);
}

class _StoreState extends State<Store> {
  String name;
  final StoreDto store;

  _StoreState(this.store);

  @override
  void initState() {
    name = this.store.name;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: const Color(0xffF8FBFF),
      body: Column(children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: screenSize().height / 15),
              mainRow(),
              Container(
                width: 350,
                height: 10,
                child: Divider(color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize().width / 25),
                      child: Text("Select sector you are working in:",
                          style: TextStyle(
                              color: Color(0xFF13497B), fontSize: 18)))),
            ],
          ),
        ),
        Nav(0),
      ]),
    );
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Row mainRow() {
    return Row(
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllStaffStoresScreen()));
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            this.store.name,
            style: TextStyle(
              color: Color(0xFF13497B),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(width: 32.0, height: 0.0),
      ],
    );
  }

  Column selectSectorSection() {
    return Column(
      children: <Widget>[
        Text(" Directions",
            style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        //Text(currentCounter.,style: TextStyle(color: Color(0xFF000000), fontSize: 20))
        Spacer(),
        RaisedButton(
            onPressed: () => openMaps(),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: Color(0xFF000000), size: 32.0),
                Text(" Directions",
                    style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
              ],
            ))
      ],
    );
  }

  Future<void> openMaps() async {
    String url = "https://www.google.com/maps/search/?api=1&query=" +
        store.address.replaceAll(" ", "+");
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
        children: [
          Text("Ahead: ",
              style: TextStyle(
                  color: Color(0xFF143656),
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Text(
              this.store.counters[0].peopleWaitingInLine.toString() + " people",
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
              (this.store.counters[0].avgWaitingTime.hour * 60 +
                          this.store.counters[0].avgWaitingTime.minute)
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
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Ticket(
                        ServerCommunicationService.getNewUserTicket(1, 1)))); */ // todo userid and counterId
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
