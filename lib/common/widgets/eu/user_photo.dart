import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/state/global/user_state.dart';

class UserPhotoWidget extends StatelessWidget {
  final double size;
  const UserPhotoWidget({
    Key? key,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UserStateController>();
    return Obx(
      () {
        if (userController.user.value == null) {
          return CircleAvatar(
            radius: size,
            child: Icon(
              Icons.person,
              size: size,
            ),
          );
        }

        return SizedBox(
          width: size,
          height: size,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8000.0),
            child: CachedNetworkImage(
              imageUrl: userController.user.value?.photoURL ?? '',
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
