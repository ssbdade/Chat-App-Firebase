import 'package:chat/app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';



class AccountRepo extends GetxService {
  static AccountRepo get to => Get.find();
  final store = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  var id = '';


  getAccountInfo(RxList<UserModel> list) {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        list.add(UserModel.fromMap(doc));
      }
    });
  }
}
