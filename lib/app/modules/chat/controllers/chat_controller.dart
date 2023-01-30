import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/data/response/messages.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController

  int limit = 10;

  RoomModel room = Get.arguments;

  TextEditingController chatController = TextEditingController();
  late Stream<QuerySnapshot> chatStream;

  ScrollController scrollController = ScrollController();

  RxList<MessageModel> listMess = <MessageModel>[].obs;


  final count = 0.obs;
  @override
  void onInit() {

    chatStream = FirebaseFirestore.instance.collection('messages').where('roomId', isEqualTo: room.roomId).orderBy('time', descending: true).limit(limit).snapshots();
    chatStream.listen((event)=> getMess2(event));
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
    print(1);
    super.onInit();
  }

  void getMess2(QuerySnapshot<Object?>? data) async {
    List<MessageModel> listTemp = [];
    for (var element in  data!.docs) {
        listTemp.add(MessageModel.fromMap(element));
    }
    listMess.value = listTemp;

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void sendMessage(String roomId) async {
    if (chatController.text != '') {
      MessageModel messageModel = MessageModel(
        time: Timestamp.now(),
        text: chatController.text,
        unread: true,
        senderId: AppPreference().getUid(),
        roomId: roomId,
      );
      listMess.add(messageModel);
      room.lastedMessage = messageModel;
      chatController.clear();
      String messId = await MessagesRepo().sendMessage(messageModel);
      await FirebaseFirestore.instance.doc("roomChats/$roomId").update(
        {
          "lastedMessage": FirebaseFirestore.instance.doc("messages/$messId"),
        }
      );

    }
  }

  void getMoreData() {
    limit+=10;
    chatStream = FirebaseFirestore.instance.collection('messages').where('roomId', isEqualTo: room.roomId).orderBy("time", descending: true).limit(limit).snapshots();
    chatStream.listen((event)=> getMess2(event));
    Logger.info("call lai");
  }


  void increment() => count.value++;
}
