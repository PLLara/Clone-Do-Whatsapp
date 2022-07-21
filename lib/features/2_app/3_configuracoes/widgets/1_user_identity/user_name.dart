import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/state/global/user_state.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UserStateController>();
    return Obx(
      () {
        var user = userController.user.value;
        if (user == null) {
          return const Text("");
        }
        return Text(
          user.displayName ?? '',
          style: TextStyle(
            color: Colors.white,
          ),
        );
      },
    );
  }
}
