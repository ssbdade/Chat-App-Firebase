import 'dart:convert';

import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  int limit = 5;

  late Stream<QuerySnapshot> roomStream1;
  late Stream<QuerySnapshot> roomStream2;

  RxList<RoomModel> listRooms = <RoomModel>[].obs;

  final User? firebaseUser = FirebaseAuth.instance.currentUser;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    // print(listFriends);
    roomStream1 = FirebaseFirestore.instance.collection('roomChats').where("uid1", isEqualTo: firebaseUser!.uid).limit(limit).snapshots();
    roomStream1.listen((event)=> getRoom1(event));
    roomStream2 = FirebaseFirestore.instance.collection('roomChats').where("uid2", isEqualTo: firebaseUser!.uid).limit(limit).snapshots();
    roomStream2.listen((event)=> getRoom2(event));
  }

  void getRoom1(QuerySnapshot<Object?>? data) async {
    List<RoomModel> listTemp = [];
    for (var element in  data!.docs) {
      listRooms.add(RoomModel.fromMap(element, "user2", element.id));
    }
  }


  void getRoom2(QuerySnapshot<Object?>? data) async {
    List<RoomModel> listTemp = [];
    for (var element in  data!.docs) {
      listRooms.add(RoomModel.fromMap(element, "user1", element.id));
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getUserInfo() {
    FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).get().then((value) {
      UserModel userModel = UserModel.fromMap(value);
      print(userModel.userId);
      print(jsonEncode(userModel.toMap()));
    });
  }

  void increment() => count.value++;

  RxInt bottomIndex = 0.obs;
}
