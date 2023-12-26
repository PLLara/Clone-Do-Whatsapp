// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state/location_state.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LocationController cLocation = Get.find();

    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
      onPressed: cLocation.buttonNextPressed,
      child: const Text('Próximo'),
    );
  }
}
