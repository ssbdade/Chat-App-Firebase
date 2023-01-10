import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Item extends StatelessWidget {
  const Item({Key? key, this.title, this.onTap}) : super(key: key);

  final String? title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 15.w),
        height: 57.h,
        color: white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title ?? "",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Spacer(),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
