import 'package:chat/app/modules/account/views/account_view.dart';
import 'package:chat/app/modules/friends/views/friends_view.dart';
import 'package:chat/app/modules/message/views/message_view.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:chat/app/util/common/screen_util.dart';
import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleSpacing: width(12),
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromRGBO(184, 207, 219, 1),
          ),
          top: BorderSide(
            color: Color.fromRGBO(184, 207, 219, 1),
          ),
        ),
        centerTitle: false,
        title: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                //color: HexColor("#7D9EBD"),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                color: red
              ),
            ),
            SizedBox(width: width(7)),
            Flexible(
                child: Container(
                    height: height(35),
                    color: Colors.white,//HexColor('#F7F7FC'),
                    child: TextFormField(
                        onChanged: (text) {

                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#E4E4E4'), width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(35.r)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:HexColor('#376178'), width: 1.0 ),
                            borderRadius: BorderRadius.all(Radius.circular(35.r)),
                          ),
                          hintText: 'Tìm kiếm bạn bè, tin nhắn...',
                          alignLabelWithHint: false,
                          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
                          contentPadding: const EdgeInsets.all(8),
                        )
                    )
                )
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
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

