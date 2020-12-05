import 'dart:typed_data';
import 'dart:ui';

import 'package:Staff/domain/day.dart';
import 'package:Staff/dto/CounterDto.dart';
import 'package:Staff/dto/ScheduleDto.dart';
import 'package:flutter/cupertino.dart';

class StoreDto {
  int id;

  String name;

  Image img;

  String address;

  int categoryId;

  List<CounterDto> counters;

  List<ScheduleDto> schedules;

  StoreDto.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
    this.img = new Image.memory(Uint8List.fromList(json['img'].cast<int>()));
    this.address = json['address'];
    this.categoryId = json['categoryId'];
    List<dynamic> counters = json['counters'];
    this.counters = counters.map((counter) => CounterDto.fromJson(counter)).toList(); //.cast<List<dynamic>>()
    List<dynamic> schedules = json['schedules'];
    this.schedules = schedules.map((schedule) => ScheduleDto.fromJson(schedule)).toList();
  }

  bool isOpened(){
    DateTime now = DateTime.now();
    int weekDay = now.weekday;
    Day day = Day.values[weekDay - 1]; // hack
    ScheduleDto schedule = schedules.firstWhere((schedule) => schedule.day == day);
    if (schedule == null) return false;
    if (now.isAfter(schedule.openingTime) && now.isBefore(schedule.closingTime)){
      return true;
    }
    return false;
  }
}