class ScheduleDto {
  ScheduleDto(this.day, this.openingTime, this.closingTime);

  String day;

  String openingTime;

  String closingTime;

  ScheduleDto.fromJson(Map<String, dynamic> json) {
    this.day = json['day'];
    this.openingTime = json['openingTime'];
    this.closingTime = json['closingTime'];
  }
}
