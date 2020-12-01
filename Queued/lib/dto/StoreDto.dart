import 'dart:typed_data';

import 'package:Queued/dto/CounterDto.dart';
import 'package:Queued/dto/ScheduleDto.dart';

class StoreDto {
  int id;

  String name;

  Uint8List img;

  String address;

  int categoryId;

  List<CounterDto> counters;

  List<ScheduleDto> schedules;

  StoreDto.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
    this.img = Uint8List.fromList(json['img'].cast<int>());
    this.address = json['address'];
    this.categoryId = json['categoryId'];
    this.counters = json['counters'].map((counter) => CounterDto.fromJson(counter)).toList(); //.cast<List<dynamic>>()
    this.schedules = json['schedules'].map((schedule) => ScheduleDto.fromJson(schedule)).toList();
  }
}