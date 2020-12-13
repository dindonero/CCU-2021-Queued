import 'package:Company/domain/day.dart';

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
  Map<String, dynamic> toJson(){
    print(this.openingTime.toString());
    print(this.closingTime.toString());
    return {'day': this.day.toString().split(".")[1], 'openingTime': (this.openingTime.hour).toString() + ":" + (this.openingTime.minute).toString() + ":00", 'closingTime': (this.closingTime.hour).toString() + ":" + (this.closingTime.minute).toString() + ":00"};
  }
}
