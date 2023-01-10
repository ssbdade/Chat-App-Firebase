import 'package:chat/app/models/user_model.dart';

class RoomModel {
  String? uid1;
  String? uid2;
  UserModel? userModel;
  String? roomId;

  RoomModel({
    this.uid1,
    this.uid2,
    this.userModel,
    this.roomId,
});


  factory RoomModel.fromMap(map, UserModel user,String roomId) {
    return RoomModel(
      uid1: map["uid1"],
      uid2: map["uid2"],
      userModel: user,
      roomId: roomId,
    );
  }

  Map<String, dynamic> toMap(UserModel userModel1, UserModel userModel2) {
    return {
      "uid1": uid1,
      "uid2": uid2,
      "user1": userModel1.toMap(),
      "user2": userModel2.toMap(),
    };
  }
}