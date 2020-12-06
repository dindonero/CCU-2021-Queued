import 'dart:math' as math;
import 'package:Staff/services/ServerCommunicationService.dart';
import 'package:Staff/app_screens/Screen/AllStaffStoresScreen.dart';
import 'package:Staff/app_screens/Screen/StoreOnScreen.dart';
import 'package:Staff/app_screens/Widget/navBarWidget.dart';
import 'package:Staff/app_screens/Widget/MainRowWidget.dart';
import 'package:Staff/dto/StoreDto.dart';
import 'package:Staff/dto/CounterDto.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreOff extends StatefulWidget {
  StoreDto store;
  CounterDto counter;


   StoreOff(this.store,this.counter);

  @override
  _StoreState createState() => _StoreState(this.store,this.counter);
}

class _StoreState extends State<StoreOff> {  
   OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );
  double _currentSliderValue = 0;
  String _currentlabel = 'closed';

  String counterName;
  StoreDto store;
  CounterDto counter;

  _StoreState(this.store,this.counter);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FBFF),
      body: Column(children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: screenSize().height / 15),
              mainRow(),
              Container(
                width: 350,
                height: 10,
                child: Divider(color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize().width / 25),
                      child: Text("Select the sector you are working in:",
                          style: TextStyle(
                              color: Color(0xFF13497B), fontSize: 18,  fontWeight: FontWeight.bold)))),
              SelectQPopUp(this.store),
                    Text("Insert name of counter you are working in:", style: TextStyle(color: Color(0xFF13497B), fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
                                  child: TextFormField(
                                  //controller: textInput,
                                    onChanged: saveCounterName,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(hintText: "Write you counter name here",
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        contentPadding:EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder,
                                    )
                                  )
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Text("Slide to open your counter:", style: TextStyle(color: Color(0xFF13497B), fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    
                    Row(
                      children: [           
                        Align (  alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
                                      child:
                            Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFF2D9CDB)),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                        ),
                              child:SliderTheme(
                                      data: SliderThemeData(
                                              thumbColor: Color(0xFF13497B),
                                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20)),
                                    child: Slider(
                                            value: _currentSliderValue,
                                            min: 0,
                                            max: 1,
                                            divisions: 1,
                                            label: _currentlabel,
                                            onChanged: (double value) {
                                              setState(() {
                                                if (_SelectQPopUpState.counter_name != null && this.counterName != null){
                                                _currentSliderValue = value;
                                                if (_currentSliderValue == 1){
                                                  _currentlabel = 'open';
                                                  ServerCommunicationService.staffHasEnteredCounter(_SelectQPopUpState.counter_id);
                                                  Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => StoreOn(this.store, _SelectQPopUpState.counter_id,_SelectQPopUpState.counter_name,this.counterName, this.counter)));
                                                }
                                              }});
                                            },
                                          ),),
                              ),
                          ),
                        ),
                         Text("Open", style: TextStyle(color: Color(0xFF000000), fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),

            ],
          ),
        ),
        Nav(0),
      ]),
    );
  }

  void saveCounterName(String name){
    this.counterName = name;
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Row mainRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.rotate(
          angle: 180 * math.pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF143656),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllStaffStoresScreen()));
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            this.store.name,
            style: TextStyle(
              color: Color(0xFF13497B),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(width: 32.0, height: 0.0),
      ],
    );
  }
 
}

class SelectQPopUp extends StatefulWidget {
   StoreDto store;
  SelectQPopUp(this.store);

  @override
  _SelectQPopUpState createState() => _SelectQPopUpState(this.store);
}

class _SelectQPopUpState extends State<SelectQPopUp> {
    StoreDto store;
    _SelectQPopUpState(this.store);

    static int counter_id;
    CounterDto selected_item;
    static String counter_name;

    void _changeValue(CounterDto counter) {
      setState(() {
        selected_item = counter;
        counter_id = counter.id;
        counter_name = counter.name;
      });
    }
    @override
    Widget build(BuildContext context) {
      return Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                children: <Widget>[
                  new DropdownButton<CounterDto>(
                    hint: Text("Select item"),
                    // value: counters[0].name,
                    value: selected_item,
                    items: store.counters.map((CounterDto value) {
                      return new DropdownMenuItem<CounterDto>(
                        value: value,
                        child: new Text(value.name),
                      );
                    }).toList(),
                    onChanged: _changeValue,
                  ),
                  
                ],
              ),
            ),
          );
  }
}

