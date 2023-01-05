import 'package:chat/app/models/models.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../util/common/logger.dart';



class RoomChatRepo extends GetxService {
  static RoomChatRepo get to => Get.find();
  final store = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  var id = '';


  getRoomChat(List<RoomModel> list) async {
    try {
      await FirebaseFirestore.instance
          .collection('roomChats')
          .where("uid2", isEqualTo: firebaseUser!.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          list.add(RoomModel.fromMap(doc,
            "user1",
            doc.id,
          ));
        });
      });
      await FirebaseFirestore.instance
          .collection('roomChats')
          .where("uid1", isEqualTo: firebaseUser!.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          list.add(RoomModel.fromMap(doc, "user2", doc.id));
        });
      });
    }
    on FirebaseException catch (e) {
      Logger.info(e.message.toString());
    }
  }


}
