// matching various patterns for kinds of data

import 'package:get/get.dart';

import '../util/constants/constants.dart';

class Validator {
  Validator();

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validator.email'.tr;
    } else {
      return null;
    }
  }

  String? password(String? value) {
    String pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validator.password'.tr;
    } else {
      return null;
    }
  }
  String? confirmPassword(String? value, String? password) {
    if(value != password) {
      return 'validator.confirmPassword'.tr;
    }
    return null;
  }

  String? name(String? value) {
    String pattern = r"(^[A-Za-z]{3,16})([ ]{0,1})([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validator.name'.tr;
    } else {
      return null;
    }
  }

  String? username(String? value) {
    String pattern = r"^[A-Za-z][A-Za-z0-9_]{5,13}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validator.username'.tr;
    } else {
      return null;
    }
  }

  String? number(String? value) {
    String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validator.number'.tr;
    } else {
      return null;
    }
  }

  String? amount(String? value) {
    String pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'validator.amount'.tr;
    } else {
      return null;
    }
  }

  String? notEmpty(String? value) {
    if (value == '') {
      return 'validator.notEmpty'.tr;
    } else {
      return null;
    }
  }
  bool phoneValidate(value){
    if(value=='') {
      return true;
    }
    String pattern = r'^((^(\+84|84|0|0084){1})(3|5|7|8|9))+([0-9]{8})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
