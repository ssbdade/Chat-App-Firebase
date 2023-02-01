import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? roomId;
  String? senderId;
  String? text;
  String? type;
  Timestamp? time;
  bool? unread;


  MessageModel(
      {
        this.roomId,
        this.senderId,
        this.text,
        this.type,
        this.time,
        this.unread
      });

  factory MessageModel.fromMap(map) {
    return MessageModel(
      senderId: map["senderId"],
      roomId: map["roomId"],
      text: map["text"],
      type: map["type"],
      time: map["time"],
      unread: map["unread"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'roomId': roomId,
      'text': text,
      'type':type,
      'time': time,
      'unread': unread,
    };
  }

}