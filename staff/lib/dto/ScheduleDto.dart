import 'package:Staff/domain/day.dart';

class ScheduleDto {
  ScheduleDto(this.day, this.openingTime, this.closingTime);

  Day day;

  DateTime openingTime;

  DateTime closingTime;

  ScheduleDto.fromJson(Map<String, dynamic> json) {
    this.day = Day.values.firstWhere((day) => day.toString() == "Day." + json['day']);
    this.openingTime = DateTime.parse("1970-01-01 " + json['openingTime']);
    this.closingTime = DateTime.parse("1970-01-01 " + json['closingTime']);
  }
}
