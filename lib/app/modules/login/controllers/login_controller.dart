import 'package:chat/app/data/response/auth.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
        print(user!.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print("loi roi $e");
        }
        else if (e.code == 'invalid-credential') {
          print("loi roi $e");
        }
      } catch (e) {
        print("loi roi $e");
      }
    }

    return user;
  }
}
