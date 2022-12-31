import 'package:chat/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageController extends GetxController {
  //TODO: Implement MessageController

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
