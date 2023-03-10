import 'package:chat/app/modules/account/widget/item.dart';
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
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: CircleAvatar(
                    radius: 35.0,
                    backgroundImage:
                    NetworkImage(controller.userModel.value.avatarUrl!),
                  ),
                ),
                SizedBox(width: 15.0),
                // Container(
                //   margin: const EdgeInsets.symmetric(horizontal: 15),
                //   height: 70.r,
                //   width: 70.r,
                //   child: CircleAvatar(
                //     child: Image.network(controller.userModel.value.avatarUrl!,fit: BoxFit.cover,),
                //   ),
                // ),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.userModel.value.fullName!,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(controller.userModel.value.email!),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Item(
            title: 'C???p nh???t th??ng tin',
            onTap: () {
              controller.toUpdatePro5Page();
            },
          ),
          SizedBox(
            height: 5,
          ),
          Item(
            title: '????ng xu???t',
            onTap: () {
              controller.logOut();
            },
          ),
        ],
      ),
    );
  }
}
