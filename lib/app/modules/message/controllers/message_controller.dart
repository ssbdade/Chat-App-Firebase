import 'dart:async';

import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/data/response/friends.dart';
import 'package:chat/app/data/response/messages.dart';
import 'package:chat/app/data/response/room_chat.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  //TODO: Implement MessageController

  CollectionReference<Map<String, dynamic>> messCollection = FirebaseFirestore.instance.collection("messages");

  int limit = 10;

  TextEditingController messController = TextEditingController();
  late Stream<QuerySnapshot> messStream;

  ScrollController scrollController = ScrollController();

  RxList<UserModel> listFriends = <UserModel>[].obs;

  RxList<RoomModel> listRooms = <RoomModel>[].obs;

  RxList<MessageModel> listMess = <MessageModel>[].obs;


  final count = 0.obs;
  @override
  void onInit() {
    messStream = FirebaseFirestore.instance.collection('messages').orderBy("time", descending: true).limit(limit).snapshots();
    messStream.listen((event)=> getMess2(event));
    AccountRepo().getAccountInfo(listFriends);
    RoomChatRepo().getRoomChat(listRooms);
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        getMoreData();

      }
    });
    super.onInit();
  }

  void getMess2(QuerySnapshot<Object?>? data) async {
    List<MessageModel> listTemp = [];
    for (var element in  data!.docs) {
      if(element["roomId"] ==   'b4efyHg1A1pQmClm3acI') {
        listTemp.add(MessageModel.fromMap(element));
      }
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

  // void getMess(String roomId, AsyncSnapshot<QuerySnapshot> snapshot) async {
  //   // listMess.value = await MessagesRepo().getMessagesList(roomId);
  //   // listMess.forEach((element) {print(element.time);});
  //   List<MessageModel> listTemp = [];
  //   for (var element in snapshot.data!.docs) {
  //     if(element["roomId"] == roomId) {
  //       listTemp.add(MessageModel.fromMap(element));
  //     }
  //   }
  //   print(listTemp[0].text);
  //   listMess.value = listTemp;
  // }

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

  void getMoreData() {
    limit+=10;
    messStream = FirebaseFirestore.instance.collection('messages').orderBy("time", descending: true).limit(limit).snapshots();
    messStream.listen((event)=> getMess2(event));
    Logger.info("call lai");
  }



  void increment() => count.value++;
}

