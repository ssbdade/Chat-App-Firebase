import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRichText extends StatelessWidget {
  const AppRichText(
      {Key? key,
      this.firstText,
      this.secondText,
      this.firstStyle,
      this.onTap,
      this.textSpace, this.alignment, this.secondStyle})
      : super(key: key);
  final String? firstText;
  final String? secondText;
  final TextStyle? firstStyle;
  final TextStyle? secondStyle;
  final Function()? onTap;
  final double? textSpace;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Align(
      alignment: alignment ?? Alignment.center,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: firstText ?? "",
            style: firstStyle ?? theme.textTheme.headline3!.copyWith(),
          ),
          WidgetSpan(
              child: SizedBox(
            width: textSpace ?? 10.w,
          )),
          WidgetSpan(
              child: GestureDetector(
                onTap: onTap,
                  child: Text(
                    secondText ?? "",
                    style: secondStyle ?? theme.textTheme.headline3!.copyWith(
                    color: blue,
                  ),
                ),
              )
          ),
        ]),
      ),
    );
  }
}
