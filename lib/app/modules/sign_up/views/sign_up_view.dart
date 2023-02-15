import 'package:chat/app/helpers/helpers.dart';
import 'package:chat/app/modules/common/widgets/widgets.dart';
import 'package:chat/app/util/constants/app_image.dart';
import 'package:chat/app/util/constants/textconst.dart';
import 'package:chat/app/util/theme/app_colors.dart';
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
      backgroundColor: blue,
      body: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: SvgPicture.asset(AppImage.bubbleChat,
                color: Colors.white,
                height: 120.h,
                alignment: Alignment.center,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r))
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      KeyConst.signUp.tr,
                      style: theme.textTheme.headline1,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    FormInputField(
                      controller: controller.emailCtrl,
                      maxLines: 1,
                      hintText: KeyConst.email.tr,
                      validator: (value) {
                        return Validator().notEmpty(value) ??
                            Validator().email(value);
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
                        return Validator().notEmpty(value) ??
                            Validator().name(value);
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    FormInputField(
                      controller: controller.profileNameCtrl,
                      maxLines: 1,
                      hintText: KeyConst.profileName.tr,
                      validator: (value) {
                        return Validator().notEmpty(value);
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
                          return Validator().notEmpty(value) ??
                              Validator().password(value);
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
                          return Validator().notEmpty(value) ??
                              Validator().confirmPassword(
                                  value, controller.passwordCtrl.text);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    AppButton(
                      onTap: () {
                        controller.signUp();
                      },
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
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
