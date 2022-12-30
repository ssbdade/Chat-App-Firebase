import 'package:chat/app/data/response/auth.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;


  final obscureText = true.obs;

  Future signIn() async {
    if(_formKey.currentState!.validate()) {
      Get.put(Auth());
      final res = await Auth.to.login(emailCtrl.text, passwordCtrl.text);
      if(res is UserModel) {
        Get.offNamed(Routes.HOME);
      }
      if (res is FirebaseAuthException) {
        Get.snackbar(res.code.tr, '');
      }
    }
  }
}
