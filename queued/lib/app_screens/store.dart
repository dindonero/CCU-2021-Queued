import 'package:Queued/app_screens/stores.dart';
import 'package:Queued/dto/StoreDto.dart';
import 'package:Queued/dto/CounterDto.dart';
import 'package:Queued/dto/ScheduleDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';
import '../domain/category.dart';
import 'storeCard.dart';
import 'navBar.dart';
import 'dart:math' as math;

class Store extends StatefulWidget {
  final StoreDto store;
  Store(this.store);

  //Stores({Key key, @required this.id}) : super(key: key);
  @override
  _StoreState createState() => _StoreState(this.store);
}

class _StoreState extends State<Store> {
 String name;
 Image img;
 final StoreDto store;
  

  _StoreState(this.store);

  @override
  void initState() {
    name = this.store.name;
    img  = this.store.img;

  }
  

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
            SizedBox(height: screenSize().height / 50),
            Container(
              width: 900,
              height: 150,
              decoration: BoxDecoration( 
                    image: DecorationImage(
                        image: img.image,
                        fit: BoxFit.cover
                    )
              ),
              child: Stack(
                children: <Widget>[
                    // Stroked text as border.
                    Center( child: Text(
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
                    Center (child:  Text(name, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 35, ),),),
                    ],
                )
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: secondRow(),
              ),
            ),
            SizedBox(height: screenSize().height / 30),
            aheadRow(),
            estimatedWaitingTimeRow(),
            SizedBox(height: screenSize().height / 15),
            getTicketButton(),
            SizedBox(height: screenSize().height / 35),
            getDailyPredictionsButton(),
            Spacer(),
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
        Text(this.store.schedules[0].openingTime + " - "  + this.store.schedules[0].closingTime,style: TextStyle(color: Color(0xFF000000), fontSize: 20)), //Text(currentCounter.,style: TextStyle(color: Color(0xFF000000), fontSize: 20))
        SizedBox(height: screenSize().height / 30),
        Spacer(),
         Icon(Icons.location_on_outlined, color: Color(0xFF000000), size: 32.0),
        Text(" Directions",style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
      ],
    );
  }

  Row aheadRow(){
    return Row(children:[ 
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
                 Text((() {
                    if(this.store.counters[0].peopleWaitingInLine == -1){
                        return "0";}

                    return this.store.counters[0].peopleWaitingInLine.toString();
                  })() ,style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
               ],
             ),
          ]);
  }

  Row estimatedWaitingTimeRow(){
      return Row(children:[
                  Align(alignment: Alignment.centerLeft, 
                    child:Padding(padding:  EdgeInsets.symmetric(
                                  horizontal: screenSize().width / 10),
                                  child:  Icon(Icons.time_to_leave, color: Color(0xFF000000), size: 80.0),
                    ),
                  ),
                  Column(children: [
                      Text("Estimated waiting time:",style: TextStyle(color: Color(0xFF143656), fontSize: 21,fontWeight: FontWeight.bold)),
                       
                       Text(this.store.counters[0].avgWaitingTime  ,style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
                  ],),
          ]);
  }

  Container getTicketButton(){
    return Container(
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
          );
  }

  Container getDailyPredictionsButton(){
    return Container(
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
            onPressed:  () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Stores(this.store.categoryId)));
                },
          ),
        ),
        Spacer(),
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