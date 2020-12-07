
class TicketDto {
  int id;

  int storeId;

  int counterId;

  int userId;

  bool canceled;

  DateTime enteringTime;

  DateTime leavingTime;

  String staffCounter;

  int peopleAheadInLine;

  DateTime estimatedWaitingTime;

  String storeName;

  String storeAddress;

  TicketDto.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.storeId = json['storeId'];
    this.counterId = json['counterId'];
    this.userId = json['userId'];
    this.canceled = json['canceled'];
    this.enteringTime = DateTime.fromMillisecondsSinceEpoch(json['enteringTime'], isUtc: true);
    if (json['leavingTime'] == 0) this.leavingTime = null;
    else this.leavingTime = DateTime.fromMillisecondsSinceEpoch(json['leavingTime'], isUtc: true);
    this.staffCounter = json['staffCounter'];
    this.peopleAheadInLine = json['peopleAheadInLine'];
    this.estimatedWaitingTime = DateTime.fromMillisecondsSinceEpoch(json['estimatedWaitingTime'], isUtc: true);
    this.storeName = json['storeName'];
    this.storeAddress = json['storeAddress'];
  }
}