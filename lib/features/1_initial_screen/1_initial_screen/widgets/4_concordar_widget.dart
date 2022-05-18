// ignore: must_be_immutable
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/navigator/go_to_page.dart';

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
            goToPage(nextScreen, Get.to);
          },
          child: const Text("CONCORDAR E AVANÇAR"),
        ),
      ),
    );
  }
}
