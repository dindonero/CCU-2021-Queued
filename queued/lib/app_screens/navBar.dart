 import 'package:Queued/app_screens/categories.dart';
 import 'package:Queued/app_screens/login.dart';
import 'package:flutter/material.dart';
 import 'queues.dart';

 class Nav extends StatefulWidget {
   @override
   _NavState createState() => _NavState();
 }

class _NavState extends State<Nav> {
    int _selectedIndex = 0;
    List<Widget> _widgetOptions = <Widget>[
      Categories(),
      Text('NO TICKETS', style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 30)),
      Text('Profile'),
      Text('Ola')
    ];

    void _onItemTap(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    @override 
    Widget build(BuildContext context){
      return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex)
        ),bottomNavigationBar: new Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        // canvasColor: Colors.green,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Color(0xff46D0D9),
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Color(0xffCCD3DB)))), // sets the inactive color of the `BottomNavigationBar`
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 25)]),
          child: new BottomNavigationBar(
        items: [
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
            title: Text('Tickets')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile')
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap
      ))));
    }
}