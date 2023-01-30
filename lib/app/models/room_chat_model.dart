import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/user_model.dart';

class RoomModel {
  String? uid1;
  String? uid2;
  UserModel? userModel;
  String? roomId;
  List<String>? participant;
  MessageModel? lastedMessage;

  RoomModel({
    this.uid1,
    this.uid2,
    this.userModel,
    this.roomId,
    this.participant,
    this.lastedMessage,
});


  factory RoomModel.fromMap(map, UserModel user,String roomId, MessageModel? messageModel) {
    return RoomModel(
      uid1: map["uid1"],
      uid2: map["uid2"],
      userModel: user,
      roomId: roomId,
      participant: [map["uid1"], map["uid2"]],
      lastedMessage: messageModel,
    );
  }

  Map<String, dynamic> toMap(UserModel userModel1, UserModel userModel2) {
    return {
      "uid1": uid1,
      "uid2": uid2,
      "user1": userModel1.toMap(),
      "user2": userModel2.toMap(),
      "participant": [uid1, uid2],
    };
  }
}