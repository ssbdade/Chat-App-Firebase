import 'package:chat/app/models/models.dart';
import 'package:chat/app/modules/common/widgets/form_input_field.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class FriendsSearch extends SearchDelegate<UserModel> {

  @override
  List<Widget> buildActions(BuildContext context) {
    Get.put(SearchController());
    SearchController controller = Get.find();
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    Get.put(SearchController());
    SearchController controller = Get.find();
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.navigate_before),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Get.put(SearchController());
    SearchController controller = Get.find();
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Get.put(SearchController());
    SearchController controller = Get.find();
    final listItems = query.isEmpty
        ? controller.listUsers
        : controller.listUsers
        .where((element) {
          final toLowe=query.toLowerCase();

      return element.fullName
      !.toLowerCase()
          .contains(toLowe) || element.email
      !.toLowerCase()
          .contains(toLowe);
    })
        .toList();
    return listItems.isEmpty
        ? const Center(child: Text("No Data Found!"))
        : ListView.builder(
        itemCount: listItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(listItems[index].fullName!),
                subtitle: Text(
                    (listItems[index].email.toString())),
                onTap: () {
                  controller.getSearchResult(listItems[index]);
                  // showResults(context);
                  // _dialogBuilder(context,listItems[index]);
                },
              ),
              Divider(),
            ],
          );
        });
  }
  Future<void> _dialogBuilder(BuildContext context,UserModel userModel) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Avatar'),
                Text(userModel.fullName ?? ""),
                Text(userModel.email ?? ""),
                Container(
                  color: Colors.blue,
                  child: Text(
                    "Add Friend",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
