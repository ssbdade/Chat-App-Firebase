import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/data/response/messages.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:chat/app/modules/message/controllers/message_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../util/theme/app_colors.dart';
import '../models/message_model.dart';

class ChatScreen extends StatefulWidget {
  // final User user;
  //
  // ChatScreen({required this.user});

  final RoomModel? room;

  const ChatScreen({super.key,required this.room});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  MessageController controller = Get.find();

  String userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  initState() {
    super.initState();
  }


  _buildMessage(MessageModel message, bool isMe) {
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
            ?const BorderRadius.only(
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

  _buildMessageComposer() {
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
            onPressed: () {},
          ),
          Expanded(
            child: TextFormField(
              controller: controller.messController,
                onChanged: (text) {
                },
                decoration: InputDecoration(
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
                  alignLabelWithHint: false,
                )
            ),
          ),
          IconButton(
            icon:const Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              controller.sendMessage(widget.room!.roomId!);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage(
                  "https://images.omerlocdn.com/resize?url=https%3A%2F%2Fgcm.omerlocdn.com%2Fproduction%2Fglobal%2Ffiles%2Fimage%2F7f510676-e91d-4e6d-a5ec-08034c3f2381.jpg&width=1024&type=jpeg&stripmeta=true"),
            ),
            const SizedBox(width: 5.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                widget.room!.userModel!.fullName!,
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
            Navigator.of(context).pop();
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
                    padding: const EdgeInsets.only(top: 15.0),
                    itemCount: controller.listMess.length,
                    itemBuilder: (BuildContext context, int index) {
                      final MessageModel message = controller.listMess[index];
                      final bool isMe = message.senderId == AppPreference().getUid();
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      )

      // StreamBuilder<QuerySnapshot>(
      //   stream: controller.messStream,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Text('Something went wrong');
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Text("Loading");
      //     }
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       print(2);
      //     }
      //     controller.getMess(widget.room!.roomId!, snapshot);
      //     return GestureDetector(
      //       onTap: () => FocusScope.of(context).unfocus(),
      //       child: Column(
      //         children: <Widget>[
      //           Expanded(
      //             child: Container( color: Colors.white,
      //               child: Obx(
      //                 () => ListView.builder(
      //                   padding: const EdgeInsets.only(top: 15.0),
      //                   itemCount: controller.listMess.length,
      //                   itemBuilder: (BuildContext context, int index) {
      //                     final MessageModel message = controller.listMess[index];
      //                     final bool isMe = message.senderId == AppPreference().getUid();
      //                     return _buildMessage(message, isMe);
      //                   },
      //                 ),
      //               ),
      //             ),
      //           ),
      //           _buildMessageComposer(),
      //         ],
      //       ),
      //     );
      //   }
      // ),
    );
  }
  String formatTimeStamp(Timestamp timestamp) {
    var date = timestamp.toDate();
    return DateFormat('hh:mm a').format(date);
  }


}
