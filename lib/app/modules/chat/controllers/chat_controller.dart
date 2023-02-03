import 'dart:io';

import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/data/response/messages.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:chat/app/modules/common/widgets/app_dialog.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController

  File? imageFile;

  int limit = 10;

  RoomModel room = Get.arguments;

  TextEditingController chatController = TextEditingController();

  String uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  CollectionReference messageRef =
      FirebaseFirestore.instance.collection('messages');
  CollectionReference requestRef =
      FirebaseFirestore.instance.collection('friendRequest');
  CollectionReference roomRef = FirebaseFirestore.instance.collection('roomChats');

  late DocumentReference currentUserRef;
  late DocumentReference theirUserRef;

  late Stream<QuerySnapshot> chatStream;

  ScrollController scrollController = ScrollController();

  RxList<MessageModel> listMess = <MessageModel>[].obs;

  RxInt index = (-1).obs;

  late Stream<QuerySnapshot> friendsRequest;

  @override
  void onInit() async {
    currentUserRef = FirebaseFirestore.instance.doc('users/$uid');
    theirUserRef = FirebaseFirestore.instance.doc('users/${room.userModel!.userId}');
    if (uid != room.userModel!.userId) {
      if (room.isFriends!.value) {
        index.value = 3;
      } else {
        await requestRef
            .where('receiver', isEqualTo: theirUserRef)
            .where('sender',
                isEqualTo: currentUserRef)
            .get()
            .then((value) async {
          if (value.size == 1) {
            index.value = 2;
          } else {
            await requestRef
                .where('receiver', isEqualTo: currentUserRef)
                .where('sender',
                    isEqualTo: theirUserRef).get()
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

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    var ref = FirebaseStorage.instance.ref().child("images").child("$fileName.jpg");
    var uploadTask = await ref.putFile(imageFile!);
    String imageUrl =  await uploadTask.ref.getDownloadURL();

   if(imageUrl != '' && room.roomId != null){
     MessageModel messageModel = MessageModel(
       time: Timestamp.now(),
       text: imageUrl,
       type: "img",
       unread: RxBool(true),
       senderId: AppPreference().getUid(),
       roomId: room.roomId,
     );
     listMess.add(messageModel);
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
       text: imageUrl,
       unread: RxBool(true),
       type: "img",
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
       'isFriends': false,
       "lastedMessage":
       FirebaseFirestore.instance.collection('messages').doc(messId),
     }).then((value) => messageRef.doc(messId).update({
       'roomId': value.id,
     }));
   }
  }

  void sendMessage() async {
    if(chatController.text != '') {
      if (room.roomId != null) {
        MessageModel messageModel = MessageModel(
          time: Timestamp.now(),
          text: chatController.text,
          unread: RxBool(true),
          type: "text",
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
          type: 'text',
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
          'isFriends': false,
          "user1": userRef.doc(uid),
          "user2": userRef.doc(room.userModel!.userId!),
          "lastedMessage":
          FirebaseFirestore.instance.collection('messages').doc(messId),
        }).then((value) => messageRef.doc(messId).update({
          'roomId': value.id,
        }));
      }
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
          //CRATE ADD FRIENDS REQUEST
          Get.dialog(
            _buildInviteFriendsAlert(),
          );
        }
        break;

      case 1:
        {
          //RESPONSE OUR REQUEST
          Get.dialog(
            _buildOurReqAlert(),
          );
        }
        break;

      case 2:
        {
          //RESPONSE THIER REQUEST
          Get.dialog(
            _buildThierReqAlert(),
          );
        }
        break;

      case 3:
        {
          Get.dialog(
            _buildRemoveFriendsAlert(),
          );
        }
        break;
    }
  }

  _buildRemoveFriendsAlert() {
    return AppDialog(
      title: 'Bạn có muốn xóa người này khỏi dánh sách bạn bè không?',
      onTapYes: () {
        removeFriends();
        Get.back();
      },

      onTapNo: () {
        Get.back();
      },
    );
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
      title: 'Bạn có muốn chấp nhận lời mời kết bạn từ người này không?',
      onTapYes: () {
        acceptFriendsRequest();
        Get.back();
      },
      rightTitle: 'XÓA',
      onTapNo: () {
        deleteThierRequest();
        Get.back();
      },
    );
  }

  _buildOurReqAlert() {
    return AppDialog(
      title: 'Bạn có muốn xóa lời mời kết bạn tới người này không?',
      onTapYes: () {
        deleteOurRequest();
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
      'receiver': theirUserRef,
      'sender': currentUserRef,
    });
    index.value = 1;
  }

  void acceptFriendsRequest() async {
    room.isFriends!.value = true;
    roomRef.doc(room.roomId).update({
      'isFriends': true,
    });
    await requestRef.where('receiver', isEqualTo: currentUserRef)
        .where('sender',
        isEqualTo: theirUserRef)
        .get()
        .then((value) {
          value.docs.forEach((document) {
            document.reference.delete();
          });
    });
    index.value = 3;
  }

  void deleteThierRequest() async {
    await requestRef.where('receiver', isEqualTo: currentUserRef)
        .where('sender',
        isEqualTo: theirUserRef)
        .get()
        .then((value) {
      value.docs.forEach((document) {
        print(document.reference);
        document.reference.delete();
      });
    });
    index.value = 0;
  }

  void deleteOurRequest() async {
    print('delete our');
    await requestRef.where('receiver', isEqualTo: theirUserRef)
        .where('sender',
        isEqualTo: currentUserRef)
        .get()
        .then((value) {
      print(value);
      value.docs.forEach((document) {
        print(document.reference);
        document.reference.delete();
      });
    });
    index.value = 0;
  }

  void removeFriends() async {
    room.isFriends!.value = false;
    roomRef.doc(room.roomId).update({
      'isFriends': false,
    });
    index.value = 0;
  }

}
