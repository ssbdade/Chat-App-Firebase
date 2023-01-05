
import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/message_model.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class MessagesRepo extends GetxService {
  Future<List<MessageModel>> getMessagesList (String roomId) async {
    List<MessageModel> listTemp = [];
    try {
      await FirebaseFirestore.instance
          .collection('messages')
      .orderBy("time")
          .get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if(doc["roomId"] == roomId) {
            listTemp.add(MessageModel.fromMap(doc));}
        });
      });
    }
    on FirebaseException catch (e) {
      Logger.info(e.code);
    }
    return listTemp;
  }

  sendMessage(MessageModel messageModel) async {
    try {
      await FirebaseFirestore.instance.collection('messages')
          .add(messageModel.toMap());
    }
    catch (e) {
      Logger.info(e.toString());
    }
  }


}

