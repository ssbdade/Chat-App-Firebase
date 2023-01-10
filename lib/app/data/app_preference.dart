import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  late SharedPreferences prefs;
  final uid = "uid";
  final userModel = "userModel";


  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveUid(String value) async {
    await prefs.setString(uid, value);
  }

  String getUid() {
    return prefs.getString(uid) ?? "";
  }

  void clear() async {
    await prefs.clear();
  }

  void saveUserModel(String value) async {
    await prefs.setString(userModel, value);
  }
  
  String getUserModel() {
    return prefs.getString(userModel) ?? "";
  }

  // Singleton
  static final AppPreference _appPreference = AppPreference._internal();

  factory AppPreference() {
    return _appPreference;
  }

  AppPreference._internal();
}
