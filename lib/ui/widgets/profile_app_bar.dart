import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/screens/auth_screen/sign_in_screen.dart';
import 'package:taskmanager/ui/screens/update_profile_screen.dart';

import '../utility/app_colors.dart';
import 'network_cached_image.dart';

AppBar profileAppBar(context, [fromUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateProfileScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          child: CircleAvatar(
              child: Image.memory(
            base64Decode(AuthController.userData?.photo ?? ''),
          )),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateProfileScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthController.userData?.fullName ?? "",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          Text(
            AuthController.userData?.email ?? "",
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(),
            ),
            (route) => false,
          );
        },
        icon: Icon(Icons.logout),
      )
    ],
  );
}
