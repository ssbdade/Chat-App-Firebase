import 'package:chat/app/util/common/screen_util.dart';
import 'package:chat/app/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar appBar() {
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
        Container(
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
        SizedBox(width: width(7)),
        Flexible(
            child: Container(
                height: height(35),
                color: Colors.white,//HexColor('#F7F7FC'),
                child: TextFormField(
                    onChanged: (text) {

                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('#E4E4E4'), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(35.r)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:HexColor('#376178'), width: 1.0 ),
                        borderRadius: BorderRadius.all(Radius.circular(35.r)),
                      ),
                      hintText: 'Tìm kiếm bạn bè, tin nhắn...',
                      alignLabelWithHint: false,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
                      contentPadding: const EdgeInsets.all(8),
                    )
                )
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
