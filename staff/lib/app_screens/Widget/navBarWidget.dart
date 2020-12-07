import 'package:flutter/material.dart';

import 'package:Staff/app_screens/Screen/AllStaffStoresScreen.dart';
import 'package:Staff/app_screens/Screen/ProfileScreen.dart';
class Nav extends StatefulWidget {
  final int id;

  Nav(this.id);

  @override
  _NavState createState() => _NavState(this.id);
}

class _NavState extends State<Nav> {
  int id;

  _NavState(this.id);

  List<Widget> _widgetOptions = <Widget>[AllStaffStoresScreen(), ProfileScreen()];

  void _onItemTap(int index) {
    setState(() {
      int _selectedIndex = index;
    });
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
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), title: Text('Profile'))
                ], currentIndex: this.id, onTap: _onItemTap))));
  }
}
