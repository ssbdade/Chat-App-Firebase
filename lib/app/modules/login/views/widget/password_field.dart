import 'package:chat/app/modules/common/widgets/widgets.dart';
import 'package:chat/app/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PasswordField extends StatefulWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return FormInputField(
      hintText: KeyConst.password.tr,
      obscureText: obscureText,
      maxLines: 1,
      suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: obscureText
              ? const Icon(Icons.visibility) :
          const Icon(Icons.visibility_off)
      ),
    );
  }
}
