// ignore: must_be_immutable
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Concordar extends StatelessWidget {
  final Widget nextScreen;

  const Concordar({
    Key? key,
    required this.nextScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Get.to(
              nextScreen,
              transition: Transition.topLevel,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          child: const Text("CONCORDAR E AVANÇAR"),
        ),
      ),
    );
  }
}

