import 'package:chat/app/data/response/search.dart';
import 'package:chat/app/modules/search/views/search_view.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/util/common/screen_util.dart';
import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    titleSpacing: width(12),
    elevation: 0,
    shape: const Border(
      bottom: BorderSide(
        color: Color.fromRGBO(184, 207, 219, 1),
      ),
      top: BorderSide(
        color: Color.fromRGBO(184, 207, 219, 1),
      ),
    ),
    centerTitle: false,
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Search search = Search();
            search.getUserList();
          },
          child: Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              //color: HexColor("#7D9EBD"),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                color: red
            ),
          ),
        ),
        SizedBox(width: width(7)),
        Expanded(
            child: GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: FriendsSearch());
              },
              child: Container(
                  height: height(35),
                decoration: BoxDecoration(
                  color: Colors.grey,//HexColor('#F7F7FC'),
                  borderRadius: BorderRadius.circular(35.r),
                ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                          child: Icon(Icons.search),
                      ),
                      Text('Tìm kiếm bạn bè, tin nhắn...'),
                    ],
                  )
              ),
            )
        ),
      ],
    ),
  );
}

AppBar accountAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    titleSpacing: width(12),
    elevation: 0,
    shape: const Border(
      bottom: BorderSide(
        color: Color.fromRGBO(184, 207, 219, 1),
      ),
      top: BorderSide(
        color: Color.fromRGBO(184, 207, 219, 1),
      ),
    ),
    centerTitle: true,
    title: Text('Tài khoản'),
  );
}
