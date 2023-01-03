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

  getAccountInfo() {
    var firebaseUser = FirebaseAuth.instance;
    var firebase = FirebaseFirestore.instance;
    firebase
        .collection('users')
        .doc(firebaseUser.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        listFriends.add(UserModel.fromMap(documentSnapshot.data()));
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  final count = 0.obs;
  @override
  void onInit() {
    getAccountInfo();
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
