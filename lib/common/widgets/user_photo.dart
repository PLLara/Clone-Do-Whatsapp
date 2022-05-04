import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/state/user_state.dart';

class UserPhotoWidget extends StatelessWidget {
  final double size;
  UserPhotoWidget({
    Key? key,
    this.size = 40,
  }) : super(key: key);
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        String? photo = userController.user.value?.photoURL;
        if (photo == null) {
          return CircleAvatar(
            radius: size,
            child: Icon(
              Icons.person,
              size: size,
            ),
          );
        }
        return CircleAvatar(
          radius: size,
          backgroundImage: NetworkImage(photo),
        );
      },
    );
  }
}
