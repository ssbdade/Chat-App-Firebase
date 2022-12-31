import 'package:chat/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/message_controller.dart';
import '../widget/favorite_contacts.dart';
import '../widget/recent_chats.dart';

class MessageView extends GetView<MessageController> {
   MessageView({Key? key, this.homeController}) : super(key: key);
  HomeController? homeController;

  @override
  Widget build(BuildContext context) {

    // print("============> ${controller.userModel.fullName}");
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('MessageView'),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:Theme.of(context).primaryColorLight,
              ),
              child: Column(
                children: <Widget>[
                  FavoriteContacts(userModel: homeController!.userModel,),
                  RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
