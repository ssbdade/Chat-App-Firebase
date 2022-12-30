import 'package:chat/app/models/models.dart';
import 'package:chat/app/modules/common/widgets/form_input_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FormInputField(
          maxLines: 1,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SearchView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}


class FriendsSearch extends SearchDelegate<UserModel> {
  @override
  List<Widget> buildActions(BuildContext context) {
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
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.navigate_before),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
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
        ? Center(child: Text("No Data Found!"))
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
                  showResults(context);
                },
              ),
              Divider(),
            ],
          );
        });
  }
}
