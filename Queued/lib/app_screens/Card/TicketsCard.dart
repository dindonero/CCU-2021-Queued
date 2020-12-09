import 'dart:math' as math;

import 'package:Queued/app_screens/Screen/TicketScreen.dart';
import 'package:Queued/dto/TicketDto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TicketsCard extends StatefulWidget {
  TicketDto ticket;
  TicketsCard(this.ticket);

  @override
  _TicketsCard createState() => _TicketsCard(this.ticket);
}

class _TicketsCard extends State<TicketsCard> {
  TicketDto ticket;
  _TicketsCard(this.ticket);

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
              ticket.storeName,
              // category.title,
              style: TextStyle(
                color: Color(0xFF143656),
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
            ]),
          children: <Widget>[ InkWell(
          onTap: ticketScreen,
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
          Text("Ticket Number:",
            style: TextStyle(
                color: Color(0xFF143656),
                fontSize: 21,
                fontWeight: FontWeight.bold)),
        Spacer(),
        Text(
            ticket.id.toString(),
            style: TextStyle(color: Color(0xFF000000), fontSize: 21)),
        ]),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Row(children: [
          Text("Estimated Waiting Time:",
              style: TextStyle(
                  color: Color(0xFF143656),
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          Spacer(),
          Text((ticket.estimatedWaitingTime.hour * 60 +
                          ticket.estimatedWaitingTime.minute)
                      .toString() +
                  " minutes",
              style: TextStyle(color: Color(0xFF000000), fontSize: 21)),
        ]),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: ticketScreen,
          child: Text("More Info",
              style: TextStyle(
              color: Color(0xff22BEC8),
              fontSize: 21,
              fontWeight: FontWeight.bold)),
        ),)
    ]));
  }

  void ticketScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Ticket(
         getTicket(this.ticket),
        ),
    ));
  }

  Future<TicketDto> getTicket(TicketDto ticket) async {
    return ticket;
  }
}
