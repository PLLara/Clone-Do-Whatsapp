import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPhotoWidget extends StatelessWidget {
  final double size;
  const UserPhotoWidget({
    Key? key,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? photo = FirebaseAuth.instance.currentUser?.photoURL;
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
  }
}
