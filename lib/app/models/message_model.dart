class MessageModel {
  String? receiverId;
  String? senderId;
  String? text;
  DateTime? time;
  bool? unread;


  MessageModel(
      {
        this.receiverId,
        this.senderId,
        this.text,
        this.time,
        this.unread
      });

  factory MessageModel.fromMap(map) {
    return MessageModel(
      senderId: map["senderId"],
      receiverId: map["receiverId"],
      text: map["text"],
      time: map["time"],
      unread: map["unread"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'time': time,
      'unread': unread,
    };
  }


}