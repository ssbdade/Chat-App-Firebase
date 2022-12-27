import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      this.title,
      this.buttonColor,
      this.titleColor,
      this.textStyle,
      this.height,
      this.borderRadius, this.onTap})
      : super(key: key);
  final String? title;
  final Color? buttonColor;
  final Color? titleColor;
  final TextStyle? textStyle;
  final double? height;
  final BorderRadius? borderRadius;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 45.h,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(2),
          color: buttonColor ?? blue,
        ),
        child: Center(
          child: Text(
            title ?? "",
            style: textStyle ??
                theme.textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: titleColor ?? white,
                ),
          ),
        ),
      ),
    );
  }
}
