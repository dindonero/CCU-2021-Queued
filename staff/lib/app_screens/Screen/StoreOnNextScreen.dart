import 'dart:ffi';
import 'dart:math' as math;
import 'package:Staff/services/ServerCommunicationService.dart';
import 'package:Staff/app_screens/Screen/AllStaffStoresScreen.dart';
import 'package:Staff/app_screens/Screen/StoreOffScreen.dart';
import 'package:Staff/app_screens/Widget/navBarWidget.dart';
import 'package:Staff/dto/StoreDto.dart';
import 'package:Staff/dto/CounterDto.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreOnNext extends StatefulWidget {
  StoreDto store;
  Future<CounterDto> counter;
  int sector_id;
  String sector_name;
  String counter_id;



   StoreOnNext(this.store, this.sector_id, this.sector_name, this.counter_id, this.counter);

  @override
  _StoreOnNextState createState() => _StoreOnNextState(this.store, this.sector_id, this.sector_name, this.counter_id, this.counter);
}

class _StoreOnNextState extends State<StoreOnNext> {
 Future<CounterDto> counter;
   OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );
  double _currentSliderValue = 1;

  String counterName;
  String _currentlabel = 'open';
  StoreDto store;
  int sector_id;
  String sector_name;
  String counter_id;


 _StoreOnNextState(this.store, this.sector_id, this.sector_name, this.counter_id, this.counter);

  @override
  void initState() {
      counter = this.counter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FBFF),
      body: Column(children: <Widget>[
        Expanded(
          child: 
                    FutureBuilder<CounterDto>(
                      future: counter,
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
                               return buildScreen(context, snapshot.data); 
  

                            }
                        }
                      })

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

   Widget buildScreen(BuildContext context, CounterDto counter){
             return  Column(
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
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize().width / 25),
                      child: Text("The sector you are working in:",
                          style: TextStyle(
                              color: Color(0xFF13497B), fontSize: 18,  fontWeight: FontWeight.bold)))),
              SizedBox(height: MediaQuery.of(context).size.height / 30),    
             Text(this.sector_name, style: TextStyle(color: Color(0xFF000000), fontSize: 18, fontWeight: FontWeight.bold)),
             SizedBox(height: MediaQuery.of(context).size.height / 30),  
             Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize().width / 25),
                      child: Text("Name of counter you are working in:", style: TextStyle(color: Color(0xFF13497B), fontSize: 18, fontWeight: FontWeight.bold)),
                    )),  
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
                                  child: Text(this.counter_id, style: TextStyle(color: Color(0xFF000000), fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Text("Slide to close your counter:", style: TextStyle(color: Color(0xFF13497B), fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    
                    Row(mainAxisAlignment: MainAxisAlignment.center,
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
                                                _currentSliderValue = value;
                                                if (_currentSliderValue == 0){
                                                  _currentlabel = 'close';
                                                   ServerCommunicationService.staffHasLeftCounter(this.sector_id);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => StoreOff(this.store,counter)));
                                                                                      }
                                              });
                                            },
                                          ),),
                              ),
                          ),
                        ),
                         Text("Open", style: TextStyle(color: Color(0xFF000000), fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
              generalInfo(),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
                     aheadRow(counter), 
                    estimatedWaitingTimeRow(counter),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                     nextTicketButton(),
                    //aheadRow(counter), 
                   // estimatedWaitingTimeRow(counter),
                ],);
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

  Column selectSectorSection() {
    return Column(
      children: <Widget>[
        Text(" Directions",
            style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        //Text(currentCounter.,style: TextStyle(color: Color(0xFF000000), fontSize: 20))
        Spacer(),
        RaisedButton(
            onPressed: () => openMaps(),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: Color(0xFF000000), size: 32.0),
                Text(" Directions",
                    style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
              ],
            ))
      ],
    );
  }

  Future<void> openMaps() async {
    String url = "https://www.google.com/maps/search/?api=1&query=" +
        store.address.replaceAll(" ", "+");
    print("launching = " + url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Column generalInfo(){
    return   Column ( children: [
      Text("General Information:", style: TextStyle(color: Color(0xFF13497B), fontSize: 22, fontWeight: FontWeight.bold)),
       SizedBox(height: MediaQuery.of(context).size.height / 30),]);
  }

   Row aheadRow(CounterDto counter) {
    return Row(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize().width / 10),
          child: Icon(Icons.people_alt, color: Color(0xFF143656), size: 60.0),
        ),
      ),
      Column(
        children: [
          Text("Current customer:",
              style: TextStyle(
                  color: Color(0xFF143656),
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Text(
              "Number " + counter.currentTicketId.toString() ,
              style: TextStyle(color: Color(0xFF143656), fontSize: 20)),

        ],
      ),
    ]);
  }

  Row estimatedWaitingTimeRow(CounterDto counter) {
      return Row(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize().width / 10),
          child: Icon(Icons.access_time_rounded,
              color: Color(0xFF000000), size: 60.0),
        ),
      ),
      Column(
        children: [
          Text("Average waiting time:",
              style: TextStyle(
                  color: Color(0xFF143656),
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          Text(
              (counter.avgWaitingTime.hour * 60 +
                          counter.avgWaitingTime.minute)
                      .toString() +
                  " minutes",
              style: TextStyle(color: Color(0xFF000000), fontSize: 20)),
        ],
      ),
    ]);
  }

  Container nextTicketButton() {
    return Container(
        width: screenSize().width/2,
        height: screenSize().height / 10,
        child: RaisedButton(
          color: Color(0xff13497B),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
             Future<CounterDto> counter = ServerCommunicationService.staffNextTicket(this.sector_id,this.sector_name);
              //play( this.new_counter);
  
              Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => StoreOnNext(this.store, this.sector_id, this.sector_name, this.counter_id,counter) //countername:A23 counter_id : index da Padaria
                     ),);},
                   // todo userid and counterId
     
          child: const Text('Next Person',
              style: TextStyle(fontSize: 25, color: Colors.white)),),
        );
  }

  Widget play(Future<CounterDto> counter){
    new FutureBuilder<CounterDto>(
                      future: counter,
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
                               return buildScreen(context, snapshot.data); 
  

                            }
                        }
                      });
  }
 
}

String formatSchedule(DateTime time) {
  String sTime;
  if (time.hour < 10)
    sTime = "0" + time.hour.toString();
  else
    sTime = time.hour.toString();
  sTime += ":";
  if (time.minute < 10)
    sTime += "0" + time.minute.toString();
  else
    sTime = time.minute.toString();
  return sTime;
}

     


