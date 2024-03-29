// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/state/global/user_state.dart';

class UserNameWidged extends StatelessWidget {
  const UserNameWidged({super.key});

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UserStateController>();

    return Obx(() {
      var user = userController.user.value;
      if (user == null) {
        return const Text("");
      }
      return Text(
        user.displayName ?? '',
      );
    });
  }
}
