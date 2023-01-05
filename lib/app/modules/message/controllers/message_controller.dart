import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/data/response/friends.dart';
import 'package:chat/app/data/response/messages.dart';
import 'package:chat/app/data/response/room_chat.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  //TODO: Implement MessageController

  TextEditingController messController = TextEditingController();



  RxList<UserModel> listFriends = <UserModel>[].obs;

  RxList<RoomModel> listRooms = <RoomModel>[].obs;

  RxList<MessageModel> listMess = <MessageModel>[].obs;


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

  void getMess(String roomId) async {
    listMess.value = await MessagesRepo().getMessagesList(roomId);
    listMess.forEach((element) {print(element.time);});



  }

  void sendMessage(String roomId) {
    if (messController.text != '') {
      MessageModel messageModel = MessageModel(
        time: Timestamp.now(),
        text: messController.text,
        unread: false,
        senderId: AppPreference().getUid(),
        roomId: roomId,
      );
      listMess.add(messageModel);
      MessagesRepo().sendMessage(messageModel);
      messController.clear();
    }

  }

  void increment() => count.value++;
}
