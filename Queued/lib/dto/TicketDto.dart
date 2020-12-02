
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

  String estimatedWaitingTime;

  String storeName;

  String storeAddress;

  TicketDto.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.storeId = json['storeId'];
    this.counterId = json['counterId'];
    this.userId = json['userId'];
    this.canceled = json['canceled'];
    this.enteringTime = json['enteringTime'];
    this.leavingTime = json['leavingTime'];
    this.staffCounter = json['staffCounter'];
    this.peopleAheadInLine = json['peopleAheadInLine'];
    this.estimatedWaitingTime = json['estimatedWaitingTime'];
    this.storeName = json['storeName'];
    this.storeAddress = json['storeAddress'];
  }
}