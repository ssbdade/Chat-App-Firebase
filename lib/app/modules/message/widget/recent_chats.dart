import 'package:chat/app/modules/home/controllers/home_controller.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/util/common/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RecentChats extends StatelessWidget {
  final HomeController controller = Get.find();

  RecentChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: Obx(
            () => ListView.builder(
              itemCount: controller.listRooms.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Logger.info(
                        'listrooom ${controller.listRooms[index].value.roomId}');
                    controller.toChatView(index);
                    print(controller
                        .listRooms[index].value.lastedMessage!.value.unread);
                    Get.toNamed(Routes.CHAT,
                        arguments: controller.listRooms[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 15.0, bottom: 5.0, right: 10.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFEFEE),
                      // color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(
                                  controller.listRooms[index].value.userModel!
                                      .avatarUrl!,
                                )),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  controller.listRooms[index].value.userModel!
                                      .fullName!,
                                  style: GoogleFonts.sarabun(
                                    textStyle: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    controller.listRooms[index].value
                                        .lastedMessage!.value.text!,
                                    style: GoogleFonts.sarabun(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF454545),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Obx(
                          () => Column(
                            children: <Widget>[
                              if (controller.listRooms[index].value
                                      .lastedMessage!.value.unread!.value &&
                                  controller.listRooms[index].value
                                          .lastedMessage!.value.senderId! !=
                                      controller.uid)
                                Container(
                                  width: 40.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'NEW',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 5.0),
                              Text(
                                formatTimeStamp(controller.listRooms[index]
                                    .value.lastedMessage!.value.time!),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String formatTimeStamp(Timestamp timestamp) {
    var date = timestamp.toDate();
    return DateFormat('hh:mm a').format(date);
  }
}
