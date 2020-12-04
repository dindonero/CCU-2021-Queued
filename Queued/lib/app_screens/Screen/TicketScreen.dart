import 'dart:math' as math;

import 'package:Queued/app_screens/Screen/StoreScreen.dart';
import 'package:Queued/dto/TicketDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';


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
            Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
                    child: mainRow(),
                  )),
            ),
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
    print(ticket);
    return Column(
      children: <Widget>[
      Text("Ticket: " + ticket.id.toString())
      ]
    );
      
  }

}