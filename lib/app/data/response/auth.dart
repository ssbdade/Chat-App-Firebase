import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';



class Auth extends GetxService {
  static Auth get to => Get.find();
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final firebaseUser = auth.FirebaseAuth.instance.currentUser;

  UserModel? _userFromFirebaseUser(auth.User? user) {
    return user != null ? UserModel(email: user.email) : null;
  }

  Future login(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      auth.User? user = result.user;
      AppPreference().saveUid(user!.uid);
      return _userFromFirebaseUser(user);
    } on auth.FirebaseAuthException catch (e) {
      Logger.info(e.code);
      return e;
    }
  }

  Future register(String fullName, String email, String password, String profileName) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User? user = result.user;
      AppPreference().saveUid(user!.uid);
      postNewUserToFireStore(fullName, profileName, result.user);
      return _userFromFirebaseUser(user);
    } on auth.FirebaseAuthException catch (e) {
      Logger.info(e.code);
      return e;
    }
  }

  //signing out from the app
  Future signOut() async {
    try {
      AppPreference().clear();
      return await _auth.signOut();
    } catch (e) {
      Logger.info(e.toString());
      return null;
    }
  }

  postNewUserToFireStore(String fullName, String profileName, auth.User? user) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Logger.info(user!.uid);
    UserModel userModel = UserModel(
      userId: user.uid,
      fullName: fullName,
      email: user.email,
      avatarUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTL_JlCFnIGX5omgjEjgV9F3sBRq14eTERK9w&usqp=CAU",
    );
    try {
      await firebaseFirestore.collection('users').add(userModel.toMap());
    }
    catch(e) {
      Logger.info(e.toString());
    }
    Logger.info("succes");
  }
}
