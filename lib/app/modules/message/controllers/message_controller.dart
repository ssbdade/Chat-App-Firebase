import 'dart:async';

import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/data/response/friends.dart';
import 'package:chat/app/data/response/messages.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  //TODO: Implement MessageController

  int limit = 10;

  TextEditingController messController = TextEditingController();
  late Stream<QuerySnapshot> messStream;

  ScrollController scrollController = ScrollController();

  RxList<UserModel> listFriends = <UserModel>[].obs;

  RxList<MessageModel> listMess = <MessageModel>[].obs;


  final count = 0.obs;
  @override
  void onInit() {
    messStream = FirebaseFirestore.instance.collection('messages').orderBy("time", descending: true).limit(limit).snapshots();
    messStream.listen((event)=> getMess2(event));
    AccountRepo().getAccountInfo(listFriends);
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
      if(element["roomId"] == 'b4efyHg1A1pQmClm3acI') {
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


  void sendMessage(String roomId) {
    if (messController.text != '') {
      MessageModel messageModel = MessageModel(
        time: Timestamp.now(),
        text: messController.text,
        unread: RxBool(false),
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

