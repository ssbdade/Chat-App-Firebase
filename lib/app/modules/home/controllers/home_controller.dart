import 'package:chat/app/data/response/friends.dart';
import 'package:chat/app/data/response/search.dart';
import 'package:chat/app/models/user_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // print(listFriends);
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

  RxInt bottomIndex = 0.obs;
}
