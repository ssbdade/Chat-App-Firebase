import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/friends_controller.dart';

class FriendsView extends GetView<FriendsController> {

   FriendsView({Key? key}) : super(key: key);

  final FriendsController friendsController = Get.put(FriendsController());

  _buildRequests(BuildContext context, int index) {
    var element = friendsController.listRequest[index];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 35.0,
            backgroundImage: NetworkImage(
                "https://images.omerlocdn.com/resize?url=https%3A%2F%2Fgcm.omerlocdn.com%2Fproduction%2Fglobal%2Ffiles%2Fimage%2F7f510676-e91d-4e6d-a5ec-08034c3f2381.jpg&width=1024&type=jpeg&stripmeta=true"),
          ),
          SizedBox(width: 10.w,),
          Expanded(
            child: Text(element["senderName"],
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(width: 10.w,),
          Container(
            width: 60.r,
            height: 30.r,
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
          itemCount: friendsController.listRequest.length,
          itemBuilder: (_, index) {
            return  _buildRequests(context, index);
          })
    );
  }
}
