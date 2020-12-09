import 'dart:math' as math;

import 'package:Company/dto/CounterDto.dart';
import 'package:Company/services/ServerCommunicationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Company/app_screens/Card/CountersCard.dart';
import '../../dto/StoreDto.dart';
import '../Widget/navBarWidget.dart';

class AddStoreScreenNext extends StatefulWidget {
  StoreDto store;

  AddStoreScreenNext({this.store});

  @override
  _AddStoreScreenNextState createState() =>
      _AddStoreScreenNextState(store: this.store);
}

class _AddStoreScreenNextState extends State<AddStoreScreenNext> {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );
  List<TextFormField> textFormFields = new List<TextFormField>();
  List<String> counterNames = new List<String>();
  StoreDto store;

  _AddStoreScreenNextState({this.store});

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: SingleChildScrollView(
            child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenSize().height / 25),
            SizedBox(height: screenSize().height / 40),
             Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [  Transform.rotate(
                          angle: 180 * math.pi / 180,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFF143656),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      Text("Maurício",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF13497B),
                              fontSize: 30)),
                       Container(width: 50,),
                    ],
                  ),
                  Container( width:360,
                    child:
                      Divider(height: 20, thickness: 2 ,color: Colors.black,),

                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
                    child: Text(" Store Schedule",
                        style: TextStyle(
                            color: Color(0xff13497b),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  )),
            ),
            SizedBox(height: screenSize().height / 60),
            Container(
                width: screenSize().width / 1.1,
                height: screenSize().height / 2.6,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(229, 235, 241, 0.8),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: daysAndHours(),
                alignment: Alignment.center),
            SizedBox(height: screenSize().height / 50),
            Row(
              children: <Widget>[
                // Alignment
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize().width / 25),
                        child: Text(" Queues",
                            style: TextStyle(
                                color: Color(0xff13497b),
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      )),
                ),
                Spacer(),
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize().width / 25),
                        child: IconButton(icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed:() {
                    setState(() {
                      textFormFields.add(buildField("Counter name"));
                    });
                  },),
                      ),
                    ),
                  ),
              ],
            ),
            _buildGridView(context),
            Container(
                width: screenSize().width / 1.2,
                height: screenSize().height / 15,
                child: RaisedButton(
                  color: Color(0xff13497B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    List<CounterDto> newCounters =  new List<CounterDto>();
                    for (String name in counterNames){
                        newCounters.add(CounterDto(name: name, hasStaff: false, peopleWaitingInLine: 0));
                    }
                    StoreDto updatedStore = StoreDto(name: store.name, imageBytes: store.imageBytes, address: store.address, categoryId: store.categoryId, counters: newCounters, schedules: store.schedules);
                    ServerCommunicationService.addNewStore(1, updatedStore).then(
                        (id) => print("StoreAdded - id:" + id.toString())); //
                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                  },
                  child: const Text('Add Store',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                )),
            SizedBox(height: screenSize().height / 30),
            SizedBox(height: screenSize().height / 30),
          ],
        )));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  void removeCounter( TextFormField index) {
    setState(() {
      counterNames.remove(counterNames[textFormFields.indexOf(index)]);
      textFormFields.remove(index);
    });
  }

Widget _buildGridView(BuildContext context) {
  if (textFormFields.length > 0){
    return GridView.builder(
      shrinkWrap: true,
      itemCount: textFormFields.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: screenSize().width / 20,
        crossAxisSpacing: screenSize().width / 25,
        childAspectRatio: 5,
      ),
      itemBuilder: (context, index) => CountersCards(removeCounter,
            textFormFields[index])
            
            //press: () => null
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => Store(
          //           getTicket(stores[index]),
          //         ),
          //       )),
          ); 
  }else{
    return Container();
   }
 }

  showAlertDialogCounters(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Accept?"),
      content: Text("Do you accept?"),
      actions: [
        okButton,
      ],
    );

    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  Column daysAndHours() {
    return Column(
      children: [
        Container(
          width: screenSize().width / 1.2,
          //A    1
          //B    2
          //C    3
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(height: screenSize().height / 9),
                          //A
                          Container(
                              child: Text(" Days:",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19))),
                          Spacer(),
                          //1
                          Container(
                            //TODO: https://pub.dev/packages/weekday_selector
                            width: screenSize().width / 1.8,
                            child: Column(children: <Widget>[
                              buildDropdownField([
                                "Monday",
                                "Tuesday",
                                "Wednesday",
                                "Thursday",
                                "Friday",
                                "Saturday",
                                "Sunday"
                              ])
                            ]),
                            alignment: Alignment.center,
                          )
                        ],
                      ),
                      SizedBox(height: screenSize().height / 40),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(" Hours:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19))),
                      SizedBox(height: screenSize().height / 120),
                      Row(
                        children: <Widget>[
                          //B
                          Container(
                              child: Text(" Opens:",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17))),
                          //2
                          Spacer(),
                          Container(
                            width: screenSize().width / 1.8,
                            child: Column(children: <Widget>[
                              buildDropdownField(["08:20", "08:30", "09:30"])
                            ]),
                            alignment: Alignment.center,
                          )
                        ],
                      ),
                      SizedBox(height: screenSize().height / 50),
                      Row(
                        children: <Widget>[
                          //C
                          Container(
                              child: Text(" Closes:",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17))),
                          //3
                          Spacer(),
                          Container(
                            width: screenSize().width / 1.8,
                            child: Column(children: <Widget>[
                              buildDropdownField(["23:00", "23:30", "23:45"])
                            ]),
                            alignment: Alignment.center,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Spacer(
                            flex: 4,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  DropdownButtonFormField buildDropdownField(List<String> lstvalues) {
    var dropdownValue = lstvalues.first;
    var dropdownButtonFormField = DropdownButtonFormField(
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 45, right: 10, top: 20, bottom: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          filled: true,
          fillColor: Color(0xffF8FBFF)),
      value: lstvalues.first,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: lstvalues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    return dropdownButtonFormField;
  }

  TextFormField buildField(String hintTextString) {
    return TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.name,

        decoration: InputDecoration(
            hintText: hintTextString,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            ),
            onChanged: saveCounterName ,);
  }

  void saveCounterName(String name){
      if (textFormFields.length ==  counterNames.length){
       counterNames[textFormFields.length - 1 ] = name;
      }else {
        counterNames.add(name);
      }
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
