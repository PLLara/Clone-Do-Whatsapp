import 'package:flutter/material.dart';
import 'package:get/get.dart';

goToPage(Widget page) {
  Get.to(
    ()=>page,
    transition: Transition.topLevel,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
}
