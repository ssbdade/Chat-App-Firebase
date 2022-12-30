import 'package:chat/app/modules/message/controllers/message_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MessageController(),);
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
