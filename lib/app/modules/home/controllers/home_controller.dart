import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  late final  UserModel userModel;

  final count = 0.obs;
  @override
  void onInit() async{
    await getUser();
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

  RxInt bottomIndex = 0.obs;

  Future<void> getUser() async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userModel = UserModel.fromMap(documentSnapshot.data());
      } else {
        print('Document does not exist on the database');

      }
    });
  }
}
