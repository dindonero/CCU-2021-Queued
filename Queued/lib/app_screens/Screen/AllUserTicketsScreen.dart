import 'dart:math' as math;

import 'package:Queued/dto/TicketDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';

import '../Widget/navBarWidget.dart';
import '../Card/TicketsCard.dart';

class AllUserTicketsScreen extends StatefulWidget {
  @override
  _AllUserTicketsScreenState createState() => _AllUserTicketsScreenState();
}

class _AllUserTicketsScreenState extends State<AllUserTicketsScreen> {
  Future<List<TicketDto>> futureTickets;
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );

  @override
  void initState() {
    futureTickets = getAllUserTickets(1); // todo insert user id
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
            SizedBox(height: screenSize().height / 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("    Hello Maurício!",
                  style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 20)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("    These are your tickets:",
                  style: TextStyle(color: Color(0xFF143656), fontSize: 20)),
            ),
            SizedBox(height: screenSize().height / 30),
            Container(
              width: 380,
              child: buildSearchField(),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  child: FutureBuilder<List<TicketDto>>(
                      future: this.futureTickets,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
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
    return GridView.builder(
        itemCount: tickets.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: screenSize().width / 15,
          crossAxisSpacing: screenSize().width / 25,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) => TicketsCard(
              ticket: tickets[index],
              // press: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => DetailsScreen(
              //         category: categories[index],
              //       ),
              //     )),
            ));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  TextFormField buildSearchField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: "What are you looking for?",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.search, color: Color(0xff27192B0), size: 32.0),
            )));
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
