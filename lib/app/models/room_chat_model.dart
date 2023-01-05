import 'package:chat/app/models/user_model.dart';

class RoomModel {
  String? uid1;
  String? uid2;
  UserModel? userModel;

  RoomModel({
    this.uid1,
    this.uid2,
    this.userModel,
});


  factory RoomModel.fromMap(map, String user) {
    return RoomModel(
      uid1: map["uid1"],
      uid2: map["uid2"],
      userModel: UserModel.fromMap(map[user]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid1": uid1,
      "uid2": uid2,
    };
  }
}