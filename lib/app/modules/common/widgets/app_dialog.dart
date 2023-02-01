import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({Key? key, this.title, this.onTapYes, this.onTapNo, this.delete})
      : super(key: key);
  final String? title;
  final Function()? onTapYes;
  final Function()? onTapNo;
  final String? delete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title!,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: onTapYes,
          child: const Text(
            'CÓ',
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTapNo,
          child: Text(
            delete ?? 'KHÔNG',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }
}
