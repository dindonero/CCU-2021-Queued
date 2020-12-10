
import 'package:Queued/app_screens/Card/StoreCard.dart';
import 'package:Queued/app_screens/Widget/MainRowWidget.dart';
import 'package:Queued/app_screens/Widget/TextSearchWidget.dart';
import 'package:Queued/app_screens/Widget/navBarWidget.dart';
import 'package:Queued/dto/CounterDto.dart';
import 'package:Queued/dto/StoreDto.dart';
import 'package:Queued/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';

import 'StoreScreen.dart';

class Stores extends StatefulWidget {
  int id = -1;
  Future<List<StoreDto>> futureStores;

  Stores(this.id);

  Stores.fromFutureStores(this.futureStores);

  @override
  _StoresState createState() => this.id != -1
      ? _StoresState(this.id)
      : _StoresState.fromFutureStores(this.futureStores);
}

class _StoresState extends State<Stores> {
  Future<List<StoreDto>> futureStores;
  int id;

  _StoresState(this.id);

  _StoresState.fromFutureStores(this.futureStores);

  @override
  void initState() {
    if (this.futureStores == null)
      futureStores = ServerCommunicationService.getStoresFromCategory(this.id);
  }

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenSize().height / 25),
            MainRowWidget(),
            SizedBox(height: screenSize().height / 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("    Hello Maurício!",
                  style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 20)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("    Please choose your store",
                  style: TextStyle(color: Color(0xFF143656), fontSize: 20)),
            ),
            SizedBox(height: screenSize().height / 30),
            TextSearchField(),
            Expanded(
                child: FutureBuilder<List<StoreDto>>(
                    future: this.futureStores,
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
            Nav(0)
          ],
        ));
  }

  Widget _buildGridView(BuildContext context, List<StoreDto> stores) {
    return GridView.builder(
      itemCount: stores.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: screenSize().width / 20,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (context, index) => StoreCard(
          store: stores[index],
          press: () => {
                if (stores[index].counters.length > 1)
                  {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SelectQPopUp(stores[index]);
                        })
                  }
                else
                  {
                    if (stores[index].counters[0].hasStaff){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Store(stores[index], stores[index].counters[0]),
                          )),
                    }
                  }
              }),
    );
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }
}

class SelectQPopUp extends StatefulWidget {
  final StoreDto store;

  SelectQPopUp(this.store);

  @override
  _SelectQPopUpState createState() => _SelectQPopUpState(this.store);
}

class _SelectQPopUpState extends State<SelectQPopUp> {
  StoreDto store;

  _SelectQPopUpState(this.store);

  int counter_id;
  CounterDto selected_item;
  String counter_name;

  void _changeValue(CounterDto counter) {
    setState(() {
      selected_item = counter;
      counter_id = counter.id;
      counter_name = counter.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Align(
        alignment: Alignment.center,
        child: Text('Select Counter:'),
      ),
      content: Padding(
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
                  child:  value.hasStaff ? new Text(value.name) : new Text(value.name + " - Closed", style: TextStyle(color: Color(0xFFFF0000)),),
                );
              }).toList(),
              onChanged: _changeValue,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 15,
                child: RaisedButton(
                  color: selected_item == null || !selected_item.hasStaff
                      ? Color(0xaaaaaaaa)
                      : Color(0xff13497B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    if (selected_item != null && selected_item.hasStaff) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Store(store, selected_item),
                          ));
                    }
                  },
                  child: const Text('Confirm',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ))
          ],
        ),
      ),
    );
  }
}
