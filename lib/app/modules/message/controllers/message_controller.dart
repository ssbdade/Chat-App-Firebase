import 'package:chat/app/data/response/friends.dart';
import 'package:chat/app/data/response/room_chat.dart';
import 'package:chat/app/data/response/search.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:chat/app/modules/message/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  //TODO: Implement MessageController




  RxList<UserModel> listFriends = <UserModel>[].obs;

  RxList<RoomModel> listRooms = <RoomModel>[].obs;


  final count = 0.obs;
  @override
  void onInit() {
    AccountRepo().getAccountInfo(listFriends);
    RoomChatRepo().getRoomChat(listRooms);


    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
