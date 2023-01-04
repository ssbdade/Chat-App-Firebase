import 'package:chat/app/helpers/helpers.dart';
import 'package:chat/app/modules/common/widgets/widgets.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/util/constants/app_image.dart';
import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../util/constants/constants.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
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
                        KeyConst.welcomeToBizflyChat.tr,
                        style: theme.textTheme.headline1,
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Text(
                      KeyConst.pleaseLogin.tr,
                      style: theme.textTheme.headline2,
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
                          return Validator().notEmpty(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "${KeyConst.forgotPassword.tr}?",
                          style: theme.textTheme.headline3!.copyWith(
                            color: blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    AppButton(
                      title: KeyConst.login.tr,
                      onTap: () async {
                        await controller.signIn();
                      },
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    AppRichText(
                      onTap: () {
                        Get.toNamed(Routes.SIGN_UP);
                      },
                      firstText: "${KeyConst.dontHaveAccount.tr}?",
                      secondText: "${KeyConst.signUp.tr}!",
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller.signInWithGoogle(context: context);
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImage.icGoogle),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Google",
                              style: theme.textTheme.headline3!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
