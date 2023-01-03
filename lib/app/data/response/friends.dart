import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/util/common/logger.dart';
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
        .doc(firebaseUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        list.add(UserModel.fromMap(documentSnapshot.data()));
      } else {
        print('Document does not exist on the database');
      }
    });
  }


}
