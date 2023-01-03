import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/message_controller.dart';
import '../widget/favorite_contacts.dart';
import '../widget/recent_chats.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MessageController());
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
                  FavoriteContacts(),
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
