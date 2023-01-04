import 'package:chat/app/data/response/friends.dart';
import 'package:chat/app/data/response/search.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/modules/message/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  //TODO: Implement MessageController




  RxList<UserModel> listFriends = <UserModel>[].obs;


  final count = 0.obs;
  @override
  void onInit() {
    AccountRepo().getAccountInfo(listFriends);
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

  void increment() => count.value++;
}
