import 'dart:convert';

import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:chat/app/util/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  //TODO: Implement UpdateProfileController
  TextEditingController nameCtrl = TextEditingController();

  Rx<UserModel> userModel = Get.arguments;

  bool success = false;

  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;

  final count = 0.obs;
  @override
  void onInit() {
    nameCtrl.text = userModel.value.fullName!;
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

  void updateProfile() async {
    userModel.value.fullName = nameCtrl.text;
    await FirebaseFirestore.instance.collection('users').doc(userModel.value.userId!).set(
        userModel.value.toMap()
    );
    AppPreference().saveUserModel(jsonEncode(userModel.value.toMap()));
    success = true;
  }

  void buildDialog(BuildContext context) {
    showDialog(context: context, builder: (__) {
      return success ? const CircularProgressIndicator() :
          AlertDialog(
            content: Container(
              height: 70,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(KeyConst.success.tr),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30,bottom: 5,top: 5),
                        child: Text(
                          KeyConst.ok.tr,style:const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
    });
  }

}
