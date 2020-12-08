import 'package:Queued/app_screens/Screen/CategoriesScreen.dart';
import 'package:Queued/app_screens/Screen/ProfileScreen.dart';
import 'package:flutter/material.dart';

import '../Screen/AllUserTicketsScreen.dart';

class Nav extends StatefulWidget {
  final int id;

  Nav(this.id);

  @override
  _NavState createState() => _NavState(this.id);
}

class _NavState extends State<Nav> {
  int id;

  _NavState(this.id);

  List<Widget> _widgetOptions = <Widget>[Categories(), AllUserTicketsScreen(),ProfileScreen()];

  void _onItemTap(int index) {
    setState(() {
      int _selectedIndex = index;
    });
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => _widgetOptions.elementAt(index)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                // canvasColor: Colors.green,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Color(0xff1EA9B4),
                textTheme: Theme.of(context).textTheme.copyWith(
                    caption: new TextStyle(color: Color(0xffCCD3DB)))),
            // sets the inactive color of the `BottomNavigationBar`
            child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.black54, blurRadius: 25)
                ]),
                child: new BottomNavigationBar(items: [
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.home),
                    title: new Text('Home'),
                  ),
                  // BottomNavigationBarItem(
                  //   icon: new Icon(Icons.location_on),
                  //   title: new Text('Location'),
                  // ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.confirmation_number_outlined),
                      title: Text('Tickets')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), title: Text('Profile'))
                ], currentIndex: this.id, onTap: _onItemTap))));
  }
}
