import 'package:flutter/material.dart';
import 'package:get/get.dart';

goToPage(Widget page, Function to) {
  to(
    () => page,
    transition: Transition.topLevel,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
}
