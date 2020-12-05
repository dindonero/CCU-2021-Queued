import 'dart:math' as math;

import 'package:Queued/app_screens/Screen/StoreScreen.dart';
import 'package:Queued/dto/TicketDto.dart';
import 'package:Queued/dto/CounterDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';
import 'package:Queued/app_screens/Widget/MainRowWidget.dart';

class Ticket extends StatefulWidget {
  Future<TicketDto> ticket;

  Ticket(this.ticket);

  //Stores({Key key, @required this.id}) : super(key: key);
  @override
  _TicketState createState() => _TicketState(this.ticket);
}

class _TicketState extends State<Ticket> {
  // String name;
  // Image img;
  int storeId;
  Future<TicketDto> ticket;
  _TicketState(this.ticket);

  @override
  void initState() {
      ticket = this.ticket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: Column(
          children: <Widget>[
            SizedBox(height: screenSize().height / 25),
            MainRowWidget(),
            Expanded(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize().width / 25),
                  child: FutureBuilder<TicketDto>(
                      future: this.ticket,
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
                            else{
                              return _buildScreen(context, snapshot.data);
                            }
                        }
                      })),
            ),
          ],
        ));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
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
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Store(this.ticket.storeId)));
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

  Widget _buildScreen(BuildContext context, TicketDto ticket) {
    return Column(
      children: <Widget>[
        SizedBox(height: screenSize().height / 30),
        Text("Ticket " + ticket.userId.toString() + " - " + ticket.storeName.toString(), style: TextStyle(fontSize: 25,
              fontWeight: FontWeight.bold, color: Color(0xFF1143656),),textAlign: TextAlign.center,),
        SizedBox(height: 10),
        Divider(color: Colors.black, thickness: 3),
        SizedBox(height: screenSize().height / 20),
        aheadRow(ticket),
        SizedBox(height: screenSize().height / 50),
        estimatedWaitingTimeRow(ticket),
        SizedBox(height: screenSize().height / 50),
        currentTicketNumberRow(ticket),
        SizedBox(height: screenSize().height / 15),
        Padding(
          padding: EdgeInsets.symmetric(
          horizontal: screenSize().width / 8),
        child: notificationsButton(),
         ),
        SizedBox(height: screenSize().height / 35),
        Padding(
          padding: EdgeInsets.symmetric(
          horizontal: screenSize().width / 8),
          child: directionsButton()
        ),
        SizedBox(height: screenSize().height / 35),
        Padding(
          padding: EdgeInsets.symmetric(
          horizontal: screenSize().width / 8),
          child: cancelButton()
        )
        ]
    );
      
  }

  Row aheadRow(TicketDto ticket) {
    return Row(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize().width / 15),
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
              ticket.peopleAheadInLine.toString() + " people",
              style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        ],
      ),
    ]);
  }

  Row estimatedWaitingTimeRow(TicketDto ticket) {
    return Row(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize().width / 15),
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
              (ticket.estimatedWaitingTime.hour * 60 +
                          ticket.estimatedWaitingTime.minute)
                      .toString() +
                  " minutes",
              style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        ],
      ),
    ]);
  }

  Row currentTicketNumberRow(TicketDto ticket) {
    return Row(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize().width / 15),
          child: Icon(Icons.confirmation_number_outlined,
              color: Color(0xFF000000), size: 60.0),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Current Ticket Number:",
              style: TextStyle(
                  color: Color(0xFF143656),
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          Text(
              (ticket.staffCounter).toString() + " - " + ticket.id.toString(),
              style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        ],
      ),
    ]);
  }

  Container notificationsButton() {
    return Container(
        width: screenSize().width,
        height: screenSize().height / 12,
        child: RaisedButton(
          color: Color(0xff13497B),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.add_alert, color: Color(0xFFFFFFFF), size: 40),
            const Text('Notify Me', style: TextStyle(fontSize: 25, color: Colors.white)),
                ])
          ));
  }

  Container directionsButton() {
    return Container(
        width: screenSize().width,
        height: screenSize().height / 12,
        child: RaisedButton(
          color: Color(0xff13497B),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.location_on_outlined, color: Color(0xFFFFFFFF), size: 40),
            const Text('Directions', style: TextStyle(fontSize: 25, color: Colors.white)),
                ])
          ));
  }

   Container cancelButton() {
    return Container(
        width: screenSize().width,
        height: screenSize().height / 12,
        child: RaisedButton(
          color: Color(0xffCC1F1F),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
          },
          child: const Text('Leave Queue', style: TextStyle(fontSize: 25, color: Colors.white)),
          ));
  }

}