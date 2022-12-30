import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Search {

  getUserList () {
    List<UserModel> listUsers = [];

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listUsers.add(UserModel.fromMap(doc));
      });
    });

    return listUsers;
  }



}


