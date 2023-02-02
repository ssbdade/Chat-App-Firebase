
import 'package:chat/app/modules/message/controllers/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteContacts extends StatelessWidget {
  MessageController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 120.0,
            child: Obx(
                () => ListView.builder(
                padding: const EdgeInsets.only(left: 10.0),
                scrollDirection: Axis.horizontal,
                itemCount: controller.listFriends.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:
                            NetworkImage(controller.listFriends[index].avatarUrl!),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            controller.listFriends[index].fullName!,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }
}