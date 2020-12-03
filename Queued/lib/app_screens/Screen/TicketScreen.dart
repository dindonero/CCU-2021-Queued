import 'dart:math' as math;

import 'package:Queued/dto/TicketDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';

import 'StoresListScreen.dart';

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
  Future<TicketDto> ticket;

  _TicketState(this.ticket);

  @override
  void initState() {
    // name = this.ticket.name;
    // img = this.ticket.img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: ListView(
            shrinkWrap: false, 
          children: <Widget>[
            Align(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                // child: mainRow(),
              ),
            ),
            Container(
                height: (screenSize().width / 2) + 25,
                // decoration: BoxDecoration(
                //     image:
                //         DecorationImage(image: img.image, fit: BoxFit.cover)),
                child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Center(
                      child: Text(
                        "name",
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
                        "name",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: screenSize().height / 30),
          ],
        ));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}