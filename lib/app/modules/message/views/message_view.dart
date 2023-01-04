import 'package:chat/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/message_controller.dart';
import '../widget/favorite_contacts.dart';
import '../widget/recent_chats.dart';

class MessageView1 extends GetView<MessageController> {
   MessageView1({Key? key}) : super(key: key);

   MessageController messageController = Get.put(MessageController());


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

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {

  final MessageController _messageController = Get.put(MessageController());

  @override
  void initState() {
    // TODO: implement initState
    _messageController.onLoad();
    super.initState();
  }

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

