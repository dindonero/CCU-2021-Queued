import 'dart:math' as math;

import 'package:Queued/dto/TicketDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';
import 'package:Queued/dto/UserAccountDto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widget/navBarWidget.dart';
import '../Card/TicketsCard.dart';

class AllUserTicketsScreen extends StatefulWidget {
  @override
  _AllUserTicketsScreenState createState() => _AllUserTicketsScreenState();
}

class _AllUserTicketsScreenState extends State<AllUserTicketsScreen> {
  Future<List<TicketDto>> futureTickets;
  UserAccountDto user = UserAccountDto(firstName: '', lastName: '');

  @override
  void initState() {
    futureTickets = ServerCommunicationService.getAllUserTickets(1); // todo insert user id
    loadProfile();
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
                    child: mainRow(),
                  )),
            ),
            SizedBox(height: screenSize().height / 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("    Hello " + user.firstName + "!",
                  style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 20)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("    These are your tickets:",
                  style: TextStyle(color: Color(0xFF143656), fontSize: 20)),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: FutureBuilder<List<TicketDto>>(
                      future: this.futureTickets,
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
                            else
                              return _buildGridView(context, snapshot.data);
                        }
                      })),
            ),
            Nav(1),
          ],
        ));
  }

  Widget _buildGridView(BuildContext context, List<TicketDto> tickets) {
    return ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) =>Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: TicketsCard(tickets[index])));
  }

  loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = UserAccountDto(
          id: prefs.getInt('id'),
          firstName: prefs.getString('firstName'),
          lastName: prefs.getString('lastName'),
          email: prefs.getString('email'),
          password: prefs.getString('password'));
    });
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Row mainRow() {
    return Row(
      children: [
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
