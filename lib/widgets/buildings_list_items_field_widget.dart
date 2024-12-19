import 'package:flutter/material.dart';

Expanded BuildingsListItemsFieldWidget({required String title, required String value, required int size}) {
  return Expanded(
      flex: size,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
            Text(value, style: TextStyle(color: Colors.white, fontSize: 12))
          ],
        ),
      ));
}