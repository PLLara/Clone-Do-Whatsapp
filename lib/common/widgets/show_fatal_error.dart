import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showFatalError(FirebaseAuthException e) {
  Get.defaultDialog(
    title: "Fatal Error!",
    content: Text(e.toString()),
    barrierDismissible: false,
    textConfirm: "Exit",
    onConfirm: () {
      Get.close(10);
    },
  );
}
