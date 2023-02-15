import 'dart:convert';

import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  int limit = 5;

  late Stream<QuerySnapshot> roomStream;

  RxList<RoomModel> listRooms = <RoomModel>[].obs;

  final String uid = FirebaseAuth.instance.currentUser!.uid;



  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    listRooms = <RoomModel>[].obs;
    roomStream = FirebaseFirestore.instance.collection('roomChats').where('participant', arrayContains: uid).limit(limit).snapshots();
    roomStream.listen((event) {getRoom(event);});
  }

  void getRoom(QuerySnapshot<Object?>? data) async {
    List<RoomModel> listTemp = [];
    for (var element in  data!.docs) {
      String user = "";
      if(element[uid] == 1) {
        user = "user2";
      }
      else {
        user = "user1";
      }
      DocumentReference<Map<String, dynamic>> documentReference = element[user];
      await documentReference.get().then((value) async {
        UserModel temp = UserModel.fromMap(value.data());
        if(element["lastedMessage"] != null) {
          DocumentReference<Map<String, dynamic>> message = element["lastedMessage"];
          await message.get().then((lastMess) {
            listTemp.add(RoomModel.fromMap(element, temp, element.id, MessageModel.fromMap(lastMess)));});
          print(element['participant']);
          // listTemp.add(RoomModel.fromMap(element, temp, element.id, null));
        }
      });
    }
    print(listTemp.length);
    listRooms.value = listTemp;
    sort();
    print("asdasdasdas $listRooms");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    print(2);
    super.onClose();
  }

  void getUserInfo() {
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      UserModel userModel = UserModel.fromMap(value);
      AppPreference().saveUserModel(jsonEncode(userModel.toMap()));
    });
  }

  void increment() => count.value++;

  RxInt bottomIndex = 0.obs;

  void sort() {
    listRooms.sort((a, b) => b.lastedMessage!.value.time!.compareTo(a.lastedMessage!.value.time!));
  }

  void toChatView(int index) {
    listRooms[index].lastedMessage!.value.unread!.value = false;
    update();


    if(listRooms[index].lastedMessage!.value.senderId != uid) {
      FirebaseFirestore.instance.collection('roomChats').doc(listRooms[index].roomId).get().then((value) {
        DocumentReference<Map<String, dynamic>> lastMessage = value["lastedMessage"];
        lastMessage.update({
          'unread': false,
        });
      });
    }
    Get.toNamed(Routes.CHAT, arguments: listRooms[index],)?.then((value) {
      if(value=='success') {
        update();
      }
    });
  }
}
