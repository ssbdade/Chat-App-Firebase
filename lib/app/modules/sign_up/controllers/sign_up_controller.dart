import 'package:chat/app/data/response/auth.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignUpController

  final obscureText = true.obs;
  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;


  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController profileNameCtrl = TextEditingController();

  Future signUp() async {
    if(_formKey.currentState!.validate()) {
      Get.put(Auth());
      final res = await Auth.to.register(fullNameCtrl.text, emailCtrl.text, passwordCtrl.text, profileNameCtrl.text);
      if (res is UserModel) {
        Get.snackbar('Đăng ký thành công', '');
        Get.offNamed(Routes.HOME);
      }
      if (res is FirebaseAuthException) {
        Get.snackbar(res.code.tr, '');
      }
    }
  }
}
