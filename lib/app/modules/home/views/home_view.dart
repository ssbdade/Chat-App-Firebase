import 'package:chat/app/modules/account/views/account_view.dart';
import 'package:chat/app/modules/common/widgets/widgets.dart';
import 'package:chat/app/modules/friends/views/friends_view.dart';
import 'package:chat/app/modules/message/controllers/message_controller.dart';
import 'package:chat/app/modules/message/views/message_view.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  late PageController pageController;

  HomeView({super.key}){
    Logger.info("da toi main page");
    pageController = PageController(
      initialPage: controller.bottomIndex.value,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Scaffold(
        appBar: controller.bottomIndex.value != 2 ? appBar(context) : accountAppBar(),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: [
            MessageView(),
            FriendsView(),
            AccountView(),
            // SettingPage(),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.bottomIndex.value,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: const Color.fromRGBO(76, 121, 147, 1),
            onTap: (value) {
              bottomTapped(value);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.message_outlined),
                label: "Tin nhan",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.people_outline),
                label: "Moi nguoi",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline),
                label: "Tai khoan",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bottomTapped(int index) {
    Logger.info('Bottom Navigation Tap $index');
    controller.bottomIndex.value = index;
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.decelerate);
    // mainController.changeCurrentIndex(index);
  }

  void onPageChanged(int index) {
    Logger.info('onPageChanged $index');
    controller.bottomIndex.value = index;
    // k = SettingPage();
  }
}

