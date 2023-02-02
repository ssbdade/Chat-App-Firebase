import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/models/models.dart';
import 'package:chat/app/modules/common/widgets/app_dialog.dart';
import 'package:chat/app/modules/message/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsController extends GetxController {
  //TODO: Implement FriendsController

  late Stream<QuerySnapshot> requestStream;

  String userId = AppPreference().getUid();

  int limit = 10;

  RxList<QueryDocumentSnapshot<Object?>> listRequest = <QueryDocumentSnapshot<Object?>>[].obs;

  RxList<UserModel> listUser = <UserModel>[].obs;

  late DocumentReference currentUserRef;

  late DocumentReference theirUserRef;

  CollectionReference requestRef =
  FirebaseFirestore.instance.collection('friendRequest');
  CollectionReference roomRef = FirebaseFirestore.instance.collection('roomChats');

  final count = 0.obs;
  @override
  void onInit() {
    currentUserRef = FirebaseFirestore.instance.doc('users/$userId');
    super.onInit();
    requestStream = FirebaseFirestore.instance.collection('friendRequest').where("receiver", isEqualTo: currentUserRef).limit(limit).snapshots();
    requestStream.listen((event) {getRequest(event);});
    print(AppPreference().getUserModel());
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


  void getRequest(QuerySnapshot<Object?>? data) async {
    List<QueryDocumentSnapshot<Object?>> listTemp = [];
    for (var element in  data!.docs) {
      DocumentReference<Map<String, dynamic>> documentReference = element["sender"];
      documentReference.get().then((value) => listUser.add(UserModel.fromMap(value.data())));
      listTemp.add(element);
    }
    listRequest.value = listTemp;
  }

  void pushAcceptButton(int index) async {
    Get.dialog(
        AppDialog(
          title: 'Bạn có muốn chấp nhận lời mời kết bạn từ người này không?',
          onTapYes: () {
            acceptFriendsRequest(index);
            Get.back();
          },
          rightTitle: 'XÓA',
          onTapNo: () {
            deleteThierRequest(index);
            Get.back();
          },
        ),
    );
  }

  void acceptFriendsRequest(int index) {
    print(index + 10000000000000000);
    theirUserRef = FirebaseFirestore.instance.doc('users/${listUser[index].userId}');
    roomRef
        .where("participant", isEqualTo: [userId, listUser[index].userId])
        .get().then((value) {
      if(value.docs.isEmpty) {
        roomRef
            .where("participant", isEqualTo: [listUser[index].userId, userId])
            .get().then((value) {
          if(value.docs.isNotEmpty) {
            value.docs[0].reference.update({
              'isFriends': true,
            });
          }
        });
      }
      else {
        value.docs[0].reference.update({
          'isFriends': true,
        });
      }
    });
    requestRef.where('receiver', isEqualTo: currentUserRef)
        .where('sender',
        isEqualTo: theirUserRef)
        .get()
        .then((value) {
      value.docs.forEach((document) {
        document.reference.delete();
      });
    });
    listUser.removeAt(index);
  }

  void deleteThierRequest(int index)  {
    theirUserRef = FirebaseFirestore.instance.doc('users/${listUser[index].userId}');
     requestRef.where('receiver', isEqualTo: currentUserRef)
        .where('sender',
        isEqualTo: theirUserRef)
        .get()
        .then((value) {
      value.docs.forEach((document) {
        print(document.reference);
        document.reference.delete();
      });
    });
    listUser.removeAt(index);
  }

}
