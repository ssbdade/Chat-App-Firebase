import 'package:chat/app/response/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignUpController

  final obscureText = true.obs;

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController profileNameCtrl = TextEditingController();

  Auth auth = Auth();

  Future signUp() async {
    auth.register(fullNameCtrl.text, emailCtrl.text, passwordCtrl.text, profileNameCtrl.text);
  }
}
