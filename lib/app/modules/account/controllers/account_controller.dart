import 'package:chat/app/data/response/auth.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  //TODO: Implement AccountController

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


  logOut() async {
    Get.put(Auth());
    Auth.to.signOut();
    Get.offNamed(Routes.LOGIN);
  }
}
