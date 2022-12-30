import 'package:chat/app/data/response/search.dart';
import 'package:chat/app/models/user_model.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController

  final count = 0.obs;
  @override
  void onInit() {
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

  List<UserModel> listUsers = Search().getUserList();
}
