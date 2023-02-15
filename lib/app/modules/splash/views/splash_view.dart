import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/util/constants/app_image.dart';
import 'package:chat/app/util/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.bg1),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImage.bubbleChat,
                color: Colors.white,
                height: 120.h,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 18.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.LOGIN);
                },
                child: SizedBox(
                  width: 277.w,
                  child: Text('Chào mừng bạn đến với MY Chat',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline1!.copyWith(
                      color: AppThemes.white,
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
