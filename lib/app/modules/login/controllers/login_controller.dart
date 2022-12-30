import 'package:chat/app/util/common/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  final obscureText = true.obs;

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCtrl.text.trim(),
          password: passwordCtrl.text.trim());
      final user = FirebaseAuth.instance.currentUser!;
      print(user.email);
    }
    catch(e) {
      Logger.info('loi roi');
      Logger.info(e.toString());
    }

  }
}
