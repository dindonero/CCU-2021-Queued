import 'package:Queued/dto/StoreDto.dart';
import 'package:Queued/dto/CounterDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';
import '../domain/category.dart';
import 'storeCard.dart';
import 'navBar.dart';
import 'dart:math' as math;

class Store extends StatefulWidget {
  //final StoreDto store;
  //Store(this.store);

  //Stores({Key key, @required this.id}) : super(key: key);
  @override
  _StoreState createState() => _StoreState(); //_StoreState(this.store);
}

class _StoreState extends State<Store> {
 // String name;
//  final StoreDto store;

  //_StoreState(this.store);

  @override
  void initState() {
   // name = this.store.name;
    //List<CounterDto> counters = this.store.counters;
    //CounterDto currentCounter = counters[0];
  }
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenSize().height / 25),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: mainRow(),
              ),
            ),
            SizedBox(height: screenSize().height / 40),
            Container(
              width: 400,
              height: 100,
              color: Colors.black,
             // child: buildSearchField(),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: secondRow(),
              ),
            ),
            SizedBox(height: screenSize().height / 30),
            Row(children:[ 
              Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:  EdgeInsets.symmetric(
                              horizontal: screenSize().width / 10),
                child:  Icon(Icons.people_alt, color: Color(0xFF000000), size: 90.0),
              ),
            ),
             Column(
               children: [
                 Text("Ahead: ",style: TextStyle(color: Color(0xFF143656), fontSize: 22, fontWeight: FontWeight.bold)),
                 Text("7 people",style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
               ],
             ),
          ]),
          Row(children:[
                  Align(alignment: Alignment.centerLeft, 
                    child:Padding(padding:  EdgeInsets.symmetric(
                                  horizontal: screenSize().width / 10),
                                  child:  Icon(Icons.time_to_leave, color: Color(0xFF000000), size: 80.0),
                    ),
                  ),
                  Column(children: [
                      Text("Estimated waiting time:",style: TextStyle(color: Color(0xFF143656), fontSize: 21,fontWeight: FontWeight.bold)),
                       Text("15-20 minutes",style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
                  ],),
          ]),
          SizedBox(height: screenSize().height / 15),
          Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(color: Color(0xFF13497B), border: Border.all( color: Color(0xFF13497B),),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:   Align(
              alignment: Alignment.center,
              child: Padding(
                padding:  EdgeInsets.symmetric(
                              horizontal: screenSize().width / 10),
                child:  Text("Get Ticket",style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            ),        
          ),
          SizedBox(height: screenSize().height / 25),
          Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(color: Color(0xFF13497B), border: Border.all( color: Color(0xFF13497B),),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                      ),]
                  ),
                  child:   Align(alignment: Alignment.center,
                    child: Padding( padding:  EdgeInsets.symmetric(
                                  horizontal: screenSize().width / 10),
                      child:  Text("Daily Predictions",style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                  ),        
          ),
          Spacer(),
            navBar(context),
          ],
        ));

 
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

 Row secondRow() {
    return Row(
      children: [
        Icon(Icons.timer_rounded, color: Color(0xFF000000), size: 32.0),
        Text("08:00 - 20:00",style: TextStyle(color: Color(0xFF000000), fontSize: 20)), //Text(currentCounter.,style: TextStyle(color: Color(0xFF000000), fontSize: 20))
        SizedBox(height: screenSize().height / 30),
        Spacer(),
         Icon(Icons.location_on_outlined, color: Color(0xFF000000), size: 32.0),
        Text(" Directions",style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
      ],
    );
  }


  Row mainRow() {
    return Row(
      children: [
          Transform.rotate(
          angle: 180 * math.pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF143656),
            ),
            onPressed: null,
          ),
        ),
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