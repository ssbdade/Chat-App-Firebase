import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/data/response/messages.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController

  int limit = 10;

  RoomModel room = Get.arguments;

  TextEditingController chatController = TextEditingController();

  String uid = FirebaseAuth.instance.currentUser!.uid;

  late Stream<QuerySnapshot> chatStream;

  ScrollController scrollController = ScrollController();

  RxList<MessageModel> listMess = <MessageModel>[].obs;


  final count = 0.obs;
  @override
  void onInit() {

    chatStream = FirebaseFirestore.instance.collection('messages').where('roomId', isEqualTo: room.roomId).orderBy('time', descending: true).limit(limit).snapshots();
    chatStream.listen((event) {
      if(room.roomId != null) {
        getMess2(event);
      }
    });
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent && room.roomId != null) {
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


  void sendMessage() async {
    if (chatController.text != '' && room.roomId != null) {
      MessageModel messageModel = MessageModel(
        time: Timestamp.now(),
        text: chatController.text,
        unread: RxBool(true),
        senderId: AppPreference().getUid(),
        roomId: room.roomId,
      );
      listMess.add(messageModel);
      room.lastedMessage!.value = messageModel;
      chatController.clear();
      String messId = await MessagesRepo().sendMessage(messageModel);
      await FirebaseFirestore.instance.doc("roomChats/${room.roomId}").update(
          {
            "lastedMessage": FirebaseFirestore.instance.doc("messages/$messId"),
          }
      );
    }
    else {
      MessageModel messageModel = MessageModel(
        time: Timestamp.now(),
        text: chatController.text,
        unread: RxBool(true),
        senderId: AppPreference().getUid(),
        roomId: room.roomId,
      );
      listMess.add(messageModel);
      room.lastedMessage!.value = messageModel;
      chatController.clear();
      String messId = await MessagesRepo().sendMessage(messageModel);
      await FirebaseFirestore.instance.collection('roomChats').add(
          {
            uid: 1,
            room.userModel!.userId!: 2,
            "participant": [uid, room.userModel!.userId],
            "uid1": uid,
            "uid2": room.userModel!.userId!,
            "user1": FirebaseFirestore.instance.collection('users').doc(uid),
            "user2": FirebaseFirestore.instance.collection('users').doc(room.userModel!.userId!),
            "lastedMessage": FirebaseFirestore.instance.collection('messages').doc(messId),
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


  Future<void> createRoom() async {

  }

  void increment() => count.value++;
}
