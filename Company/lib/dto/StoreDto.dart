import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:Company/domain/day.dart';
import 'package:Company/dto/CounterDto.dart';
import 'package:Company/dto/ScheduleDto.dart';
import 'package:flutter/cupertino.dart';

class StoreDto {

  StoreDto({this.id, this.name, this.img, this.imageBytes, this.address, this.categoryId, this.counters, this.schedules});

  int id;

  String name;

  Image img;

  Uint8List imageBytes;

  String address;

  int categoryId;

  List<CounterDto> counters;

  List<ScheduleDto> schedules;

  StoreDto.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.img = new Image.memory(Uint8List.fromList(json['img'].cast<int>()));
    this.imageBytes = Uint8List.fromList(json['img'].cast<int>());
    this.address = json['address'];
    this.categoryId = json['categoryId'];
    List<dynamic> counters = json['counters'];
    this.counters = counters
        .map((counter) => CounterDto.fromJson(counter))
        .toList(); //.cast<List<dynamic>>()
    List<dynamic> schedules = json['schedules'];
    this.schedules =
        schedules.map((schedule) => ScheduleDto.fromJson(schedule)).toList();
  }

  Map<String, dynamic> toJson(){
    return {'id': this.id ,'name': this.name, 'img': this.imageBytes, 'address': this.address, 'categoryId': this.categoryId, 'counters': this.counters, 'schedules': this.schedules.map((schedule) => schedule.toJson()).toList()};
  }

  bool isOpened() {
    DateTime now = DateTime.now();
    int weekDay = now.weekday;
    Day day = Day.values[weekDay - 1]; // hack
    ScheduleDto schedule =
        schedules.firstWhere((schedule) => schedule.day == day);
    if (schedule == null) return false;
    if (now.isAfter(schedule.openingTime) &&
        now.isBefore(schedule.closingTime)) {
      return true;
    }
    return false;
  }
}
