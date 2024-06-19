import 'package:flutter/material.dart';

Widget IconButtonColumn({
  required Function()? onPressed,
  required IconData icon,
  required String text,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
      ),
      SizedBox(height: 4),
      Text(
        text,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ],
  );
}
