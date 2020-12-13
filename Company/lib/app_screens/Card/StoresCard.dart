import 'dart:developer';
import 'dart:ffi';
import 'dart:math' as math;

import 'package:Company/app_screens/Screen/EditStoreScreen.dart';
import 'package:Company/dto/CounterDto.dart';
import 'package:Company/dto/StoreDto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoresCards extends StatefulWidget {
  StoreDto store;
  String companyName;

  StoresCards(this.store, this.companyName);

  @override
  _StoresCards createState() => _StoresCards(this.store, this.companyName);
}

class _StoresCards extends State<StoresCards> {
  StoreDto store;
  String companyName;
  _StoresCards(this.store, this.companyName);


  @override
  Widget build(BuildContext context) {
    return Card(elevation: 10, 
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15), // if you need this
      side: BorderSide(
        color: Color(0xff13497B),
        width: 2,
      ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: 
        ExpansionTile(
            title: Row(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Transform.rotate(
              angle: 225 * math.pi / 180,
              child: Icon(Icons.confirmation_number_outlined,
                  color: Colors.black, size: 45.0),
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              store.name,
              // category.title,
              style: TextStyle(
                color: Color(0xFF143656),
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
            ]),
          children: <Widget>[ InkWell(
         //onTap: ticketScreen,
            child: showInfo(),
          )
          ]
      ),
      ),
    );
  }

  Padding showInfo(){
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10), child:Column( 
      crossAxisAlignment: CrossAxisAlignment.start,children: [
         Divider(color: Colors.black, thickness: 3),
      SizedBox(height: MediaQuery.of(context).size.height / 30),
         Row(children: [
          Text("Avg. Customers in counters:",
            style: TextStyle(
                color: Color(0xFF143656),
                fontSize: 21,
                fontWeight: FontWeight.bold)),
        Spacer(),
        Text(
            getAvgNumberofcustomers(store).toString(),
            style: TextStyle(color: Color(0xFF000000), fontSize: 21)),
        ]),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Row(children: [
          Text("Average Waiting Time:",
              style: TextStyle(
                  color: Color(0xFF143656),
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          Spacer(),
          Text((getAvgWaitingTime(store).hour * 60 +
                          getAvgWaitingTime(store).minute)
                      .toString() +
                  " minutes",
              style: TextStyle(color: Color(0xFF000000), fontSize: 21)),
        ]),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Row(
          children: [
            Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: editScreen,
              child: Text("Edit",
                  style: TextStyle(
                  color: Color(0xff22BEC8),
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
            ),),
            Spacer(),
             Align(
            alignment: Alignment.centerRight,
            child: InkWell(
             // onTap: ticketScreen,
              child: Text("More",
                  style: TextStyle(
                  color: Color(0xff22BEC8),
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
            ),),
          ],
        )
    ]));
  }

  double getAvgNumberofcustomers(StoreDto store){
    List<CounterDto> counters = store.counters;
    int sum = 0;
    for (CounterDto counter in counters){
      sum = sum + counter.peopleWaitingInLine;
    }
    return sum/counters.length;
  }

  DateTime getAvgWaitingTime(StoreDto store){
    List<CounterDto> counters = store.counters;
    DateTime sum = new DateTime(0,0,0);
    for (CounterDto counter in counters){
      sum = sum.add(new Duration(hours: counter.avgWaitingTime.hour, minutes: counter.avgWaitingTime.minute));
    }
    double avgHour = sum.hour/counters.length;
    double avgMinute = sum.minute/counters.length;
    return DateTime(0,0,0,avgHour.toInt(),avgMinute.toInt());
  }

  void editScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditStoreScreen(
         this.store,
         this.companyName
        ),
    ));
  }

}
