import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/data/response/search.dart';
import 'package:chat/app/models/room_chat_model.dart';
import 'package:chat/app/models/user_model.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController

  final count = 0.obs;
  int limit = 5;
  var collectRef = FirebaseFirestore.instance.collection('roomChats');
  var userRef = FirebaseFirestore.instance.collection('users');

  RxList<UserModel> listUsers = <UserModel>[].obs;

  late Stream<QuerySnapshot> userStream;

  @override
  void onInit() {
    listUsers.value = Search().getUserList();
    userStream = userRef.limit(limit).snapshots();
    userStream.listen((event) {listUsers.value = getSearchUser(event);});
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

  getSearchResult(UserModel userModel) async {
    String uid = AppPreference().getUid();
    RoomModel roomModel;
    collectRef
        .where("participant", isEqualTo: [uid, userModel.userId])
        .get().then((value) {
      if(value.docs.isEmpty) {
        collectRef
            .where("participant", isEqualTo: [userModel.userId, uid])
            .get().then((value) {
              if(value.docs.isEmpty) {
                collectRef.add(
                  {
                    uid: 1,
                    userModel.userId!: 2,
                    "participant": [uid, userModel.userId],
                    "uid1": uid,
                    "uid2": userModel.userId!,
                    "user1": userRef.doc(uid),
                    "user2": userRef.doc(userModel.userId!),
                  }
                ).then((doc) {
                  doc.get().then((room) {
                    Logger.info(userModel.userId!);
                    roomModel = RoomModel.fromMap(room, userModel, room.id, null);
                    Get.toNamed(Routes.CHAT, arguments: roomModel);
                  });
                });
              }
              else {
                Logger.info(userModel.userId!);
                roomModel = RoomModel.fromMap(value.docs[0], userModel, value.docs[0].id, null);
                Get.toNamed(Routes.CHAT, arguments: roomModel);
              }
            });
        }
      else {
        roomModel = RoomModel.fromMap(value.docs[0], userModel, value.docs[0].id, null);
        Get.toNamed(Routes.CHAT, arguments: roomModel);
      }
    });
  }

  getSearchUser(QuerySnapshot<Object?>? data) {
    List<UserModel> listTemp = [];
    for (var element in  data!.docs) {
      listTemp.add(UserModel.fromMap(element));
    }
    return listTemp;
  }
}
