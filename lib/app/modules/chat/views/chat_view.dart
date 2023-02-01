import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/util/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               CircleAvatar(
                radius: 15.0,
                backgroundImage: NetworkImage(
                    controller.room.userModel!.avatarUrl!,)
              ),
              const SizedBox(width: 5.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  controller.room.userModel!.fullName!,
                  style:const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            color: Colors.white,
            onPressed: () {
              Get.back(result: 'success');
            },
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info_outlined),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container( color: Colors.white,
                  child: Obx(
                        () => ListView.builder(
                      controller: controller.scrollController,
                      reverse: true,
                      padding: const EdgeInsets.only(top: 15.0),
                      itemCount: controller.listMess.length,
                      itemBuilder: (BuildContext context, int index) {
                        final MessageModel message = controller.listMess[index];
                        final bool isMe = message.senderId == AppPreference().getUid();
                        return _buildMessage(message, isMe,context);
                      },
                    ),
                  ),
                ),
              ),
              _buildMessageComposer(context),
            ],
          ),
        )
    );
  }

  _buildMessage(MessageModel message, bool isMe, BuildContext context) {
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 80.0,
      )
          :const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          right: 80
      ),
      padding:const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Colors.blueAccent : Colors.grey.shade200,
        borderRadius: isMe
            ? const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        )
            :const BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            formatTimeStamp(message.time!),
            style: TextStyle(
              color:isMe ? Colors.white70 :Colors.black54,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            message.text!,
            style: TextStyle(
              color: isMe ? Colors.white70 :Colors.black54,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    return msg;
  }

  _buildMessageComposer(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon:const Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {

            },
          ),
          Expanded(
            child: TextFormField(
                controller: controller.chatController,
                onChanged: (text) {
                },
                minLines: 1,
                maxLines: 2,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
                  isDense: true,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(7.0),
                      )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: HexColor('#E4E4E4'), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(35.r)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:HexColor('#376178'), width: 1.0 ),
                    borderRadius: BorderRadius.all(Radius.circular(35.r)),
                  ),
                  hintText: 'Send a message ...',
                  // alignLabelWithHint: false,
                )
            ),
          ),
          IconButton(
            icon:const Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              controller.sendMessage();
            },
          ),
        ],
      ),
    );
  }

  String formatTimeStamp(Timestamp timestamp) {
    var date = timestamp.toDate();
    return DateFormat('hh:mm a').format(date);
  }
}
