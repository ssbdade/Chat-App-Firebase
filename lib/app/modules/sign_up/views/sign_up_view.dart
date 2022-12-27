import 'package:chat/app/helpers/helpers.dart';
import 'package:chat/app/modules/common/widgets/widgets.dart';
import 'package:chat/app/util/constants/app_image.dart';
import 'package:chat/app/util/constants/textconst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImage.loginBg,
                  height: 188.h,
                ),
                Positioned(
                    bottom: 0,
                    left: 25.w,
                    child: SvgPicture.asset(AppImage.logo2)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    width: 277,
                    child: Text(
                      KeyConst.welcomeToSignBizflyChat.tr,
                      style: theme.textTheme.headline1,
                    ),
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Text(
                    KeyConst.pleaseEnterInformation.tr,
                    style: theme.textTheme.headline2,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  FormInputField(
                    controller: controller.usernameCtrl,
                    maxLines: 1,
                    hintText: KeyConst.userName.tr,
                    validator: (value) {
                      return Validator().username(value);
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  FormInputField(
                    controller: controller.fullNameCtrl,
                    maxLines: 1,
                    hintText: KeyConst.fullName.tr,
                    validator: (value) {
                      return Validator().name(value);
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Obx(
                    () => FormInputField(
                      controller: controller.passwordCtrl,
                      hintText: KeyConst.password.tr,
                      obscureText: controller.obscureText.value,
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controller.obscureText.value =
                                !controller.obscureText.value;
                          },
                          child: controller.obscureText.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      validator: (value) {
                        return Validator().password(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Obx(
                    () => FormInputField(
                      controller: controller.confirmPasswordCtrl,
                      hintText: KeyConst.repeatPassword.tr,
                      obscureText: controller.obscureText.value,
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controller.obscureText.value =
                                !controller.obscureText.value;
                          },
                          child: controller.obscureText.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      validator: (value) {
                        return Validator().confirmPassword(value, controller.passwordCtrl.text);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AppButton(
                    title: KeyConst.signUp.tr,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AppRichText(
                    onTap: () {
                      Get.back();
                    },
                    firstText: "${KeyConst.alreadyHaveAccount.tr}?",
                    secondText: "${KeyConst.login.tr}!",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
