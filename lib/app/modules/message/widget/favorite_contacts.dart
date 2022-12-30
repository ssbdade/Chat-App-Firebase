import 'package:flutter/material.dart';

class FavoriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 120.0,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: const <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:
                          NetworkImage("https://static.wixstatic.com/media/84a5c9_463b60f413b64f8f97775a258e69eab3~mv2.jpg/v1/fill/w_640,h_812,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/84a5c9_463b60f413b64f8f97775a258e69eab3~mv2.jpg"),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          "Name",
                          style: TextStyle(
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
        ],
      ),
    );
  }
}