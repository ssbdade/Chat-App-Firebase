import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/data/response/messages.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:chat/app/modules/common/widgets/app_dialog.dart';
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

  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  CollectionReference messageRef =
      FirebaseFirestore.instance.collection('messages');
  CollectionReference requestRef =
      FirebaseFirestore.instance.collection('friendRequest');
  CollectionReference roomRef = FirebaseFirestore.instance.collection('rooms');

  late Stream<QuerySnapshot> chatStream;

  ScrollController scrollController = ScrollController();

  RxList<MessageModel> listMess = <MessageModel>[].obs;

  RxInt index = (-1).obs;

  late Stream<QuerySnapshot> friendsRequest;

  @override
  void onInit() async {
    if (uid != room.userModel!.userId) {
      if (room.isFriends!.value) {
        index.value = 2;
      } else {
        await requestRef
            .where('receiverId', isEqualTo: room.userModel!.userId)
            .where('sender',
                isEqualTo: FirebaseFirestore.instance.doc('users/$uid'))
            .get()
            .then((value) async {
          if (value.size == 1) {
            index.value = 1;
          } else {
            await requestRef
                .where('receiverId', isEqualTo: uid)
                .where('sender',
                    isEqualTo: FirebaseFirestore.instance
                        .doc('users/${room.userModel!.userId}')).get()
                .then((value) {
              if (value.size == 1) {
                index.value = 2;
              } else {
                index.value = 0;
              }
            });
          }
        });
      }
    }
    chatStream = messageRef
        .where('roomId', isEqualTo: room.roomId)
        .orderBy('time', descending: true)
        .limit(limit)
        .snapshots();
    chatStream.listen((event) {
      if (room.roomId != null) {
        getMess2(event);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          room.roomId != null) {
        getMoreData();
      }
    });
    print(1);
    super.onInit();
  }

  void getMess2(QuerySnapshot<Object?>? data) async {
    List<MessageModel> listTemp = [];
    for (QueryDocumentSnapshot<Object?>? element in data!.docs) {
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
      await FirebaseFirestore.instance.doc("roomChats/${room.roomId}").update({
        "lastedMessage": FirebaseFirestore.instance.doc("messages/$messId"),
      });
    } else {
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
      await roomRef.add({
        uid: 1,
        room.userModel!.userId!: 2,
        "participant": [uid, room.userModel!.userId],
        "uid1": uid,
        "uid2": room.userModel!.userId!,
        "user1": userRef.doc(uid),
        "user2": userRef.doc(room.userModel!.userId!),
        "lastedMessage":
            FirebaseFirestore.instance.collection('messages').doc(messId),
      });
    }
  }

  void getMoreData() {
    limit += 10;
    chatStream = messageRef
        .where('roomId', isEqualTo: room.roomId)
        .orderBy("time", descending: true)
        .limit(limit)
        .snapshots();
    chatStream.listen((event) => getMess2(event));
    Logger.info("call lai");
  }

  Future<void> createRoom() async {}

  void addFriendsButton() {
    switch (index.value) {
      case 0:
        {
          //INVITE ADD FRIENDS REQUEST
          Get.dialog(
            _buildInviteFriendsAlert(),
          );
        }
        break;

      case 1:
        {
          //ACCEPT FRIENDS REQUEST
          Get.dialog(
            _buildThierReqAlert(),
          );
        }
        break;

      case 2:
        {
          Get.dialog(
            _buildOurReqAlert(),
          );
        }
        break;
    }
  }

  _buildInviteFriendsAlert() {
    return AppDialog(
      title: 'Bạn có muốn gửi lời mời kết bạn tới người này không?',
      onTapYes: () {
        createFriendsRequest();
        Get.back();
      },

      onTapNo: () {
        Get.back();
      },
    );
  }

  _buildThierReqAlert() {
    return AppDialog(
      title: 'Bạn có muốn xóa lời mời kết bạn tới người này không?',
      onTapYes: () {
        Get.back();
      },

      onTapNo: () {
        Get.back();
      },
    );
  }

  _buildOurReqAlert() {
    return AppDialog(
      title: 'Bạn có muốn chấp nhận lời mời kết bạn từ người này không?',
      delete: 'XOÁ',
      onTapYes: () {
        Get.back();
      },
      onTapNo: () {
        Get.back();
      },
    );
  }



  void createFriendsRequest() async {
    await requestRef.add({
      'pending': true,
      'receiverId': uid,
      'sender': userRef.doc(room.userModel!.userId!),
    });
    index.value = 1;
  }

  void acceptFriendsRequest() async {
    // room.isFriends!.value = true;
    // roomRef.doc(room.roomId).update({
    //   'isFriends': true,
    // });
    // // WriteBatch batch = FirebaseFirestore.instance.batch();
    // // await requestRef.where('receiverId', isEqualTo: room.userModel!.userId)
    // //     .where('sender',
    // //     isEqualTo: FirebaseFirestore.instance.doc('users/$uid'))
    // //     .get()
    // //     .then((value) {
    // //       value.docs.forEach((document) {
    // //         batch.delete(document.reference);
    // //       });
    // // });
  }

  void deleteThierRequest() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    await requestRef.where('receiverId', isEqualTo: room.userModel!.userId)
        .where('sender',
        isEqualTo: FirebaseFirestore.instance.doc('users/$uid'))
        .get()
        .then((value) {
      value.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });
  }


}
