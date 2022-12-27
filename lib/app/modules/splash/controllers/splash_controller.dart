import 'dart:async';

import 'package:chat/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  late Timer _timer;

  @override
  void onInit() {
    _timer = Timer(const Duration(seconds: 3), () {
      Get.offNamed(Routes.LOGIN);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

}
