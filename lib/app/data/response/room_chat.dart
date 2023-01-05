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


  getRoomChat( List<RoomModel> list) async {
    await FirebaseFirestore.instance
        .collection('roomChats')
    .where("uid2", isEqualTo: firebaseUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        list.add(RoomModel.fromMap(doc,
            "user1"
        ));
      });
    });
    await FirebaseFirestore.instance
        .collection('roomChats')
        .where("uid1", isEqualTo: firebaseUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        list.add(RoomModel.fromMap(doc, "user2"));
      });
    });
    print("asdasdasdasdasd: ${list[0].userModel!.fullName}");
  }


  getFriendUser(String uid, UserModel res) {
    FirebaseFirestore.instance.
    collection('users').where('userId', isEqualTo: uid)
        .get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        res =  UserModel.fromMap(doc);
        Logger.info(res.fullName.toString());
        });
      }
    );
  }

}
