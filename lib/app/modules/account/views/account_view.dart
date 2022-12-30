import 'package:chat/app/util/common/logger.dart';
import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AccountController());
    return Scaffold(
      backgroundColor: HexColor('#F7F7F7'),
      body: Column(
        children: [
          Container(
            height: 90.h,
            color: white,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: black,
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 70.r,
                  width: 70.r,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nhất Hoàng',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text('abcxyz@gmail.com'),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              Logger.info("update pro5");
            },
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 15.w),
              height: 57.h,
              color: white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Cập nhật thông tin',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              controller.logOut();
            },
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 15.w),
              height: 57.h,
              color: white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Đăng xuất',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
