import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/friends_controller.dart';

class FriendsView extends GetView<FriendsController> {
  const FriendsView({Key? key}) : super(key: key);

  _buildRequests(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            height: 80.r,
            width: 80.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: red,
            ),
          ),
          SizedBox(width: 10.w,),
          Expanded(
            child: Text('Name',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(width: 10.w,),
          Container(
            width: 80.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Accept',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 7,
          itemBuilder: (_, index) => _buildRequests(context))
    );
  }
}
