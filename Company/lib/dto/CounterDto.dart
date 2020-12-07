class CounterDto {

  CounterDto({this.id,this.name,this.storeId,this.hasStaff,this.peopleWaitingInLine,this.avgWaitingTime,this.currentTicketId});

  int id;

  String name;

  int storeId;

  bool hasStaff; // is opened

  int peopleWaitingInLine;

  DateTime avgWaitingTime;

  int currentTicketId;

  CounterDto.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
    this.storeId = json['storeId'];
    this.hasStaff = json['hasStaff'];
    this.peopleWaitingInLine = json['peopleWaitingInLine'];
    this.avgWaitingTime = DateTime.fromMillisecondsSinceEpoch(json['avgWaitingTime'], isUtc: true);
    this.currentTicketId = json['currentTicketId'];
  }

}