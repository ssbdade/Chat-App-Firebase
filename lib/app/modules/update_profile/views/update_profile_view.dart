import 'package:chat/app/helpers/validator.dart';
import 'package:chat/app/modules/common/widgets/widgets.dart';
import 'package:chat/app/util/constants/textconst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  const UpdateProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyConst.updatePro5.tr),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Get.back(result: true);
            },
            child: Icon(Icons.chevron_left)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                FormInputField(
                  controller: controller.nameCtrl,
                  maxLines: 1,
                  hintText: KeyConst.fullName.tr,
                  validator: (value) {
                    return Validator().notEmpty(value) ??
                        Validator().name(value);
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                AppButton(
                  title: KeyConst.update.tr,
                  onTap: () {
                    controller.updateProfile();
                    controller.buildDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
