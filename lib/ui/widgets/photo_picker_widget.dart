import 'package:flutter/material.dart';

Widget buildPhotoPickerWidget() {
  return Container(
    height: 48,
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.centerLeft,
    child: Container(
      width: 100,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        "Photo",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
  );
}