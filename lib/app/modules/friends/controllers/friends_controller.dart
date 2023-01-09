import 'dart:convert';

import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsController extends GetxController {
  //TODO: Implement FriendsController

  late Stream<QuerySnapshot> requestStream;

  String userId = AppPreference().getUid();
  // UserModel userModel = jsonDecode(AppPreference().getUserModel());

  int limit = 10;

  RxList<QueryDocumentSnapshot<Object?>> listRequest = <QueryDocumentSnapshot<Object?>>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    requestStream = FirebaseFirestore.instance.collection('friendRequest').where("receiverId", isEqualTo: userId).limit(limit).snapshots();
    requestStream.listen((event) {getRequest(event);});
    print(AppPreference().getUserModel());
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


  void getRequest(QuerySnapshot<Object?>? data) async {
    List<QueryDocumentSnapshot<Object?>> listTemp = [];
    for (var element in  data!.docs) {
      listTemp.add(element);
    }
    listRequest.value = listTemp;
  }
}
