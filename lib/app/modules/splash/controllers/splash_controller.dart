import 'dart:async';

import 'package:chat/app/data/app_preference.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  late Timer _timer;

  @override
  void onInit() {
    _timer = Timer(const Duration(seconds: 3), () {
      if(AppPreference().getUid() != '') {
        Get.offNamed(Routes.HOME);
      }
      else {
        Get.offNamed(Routes.LOGIN);
      }
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
