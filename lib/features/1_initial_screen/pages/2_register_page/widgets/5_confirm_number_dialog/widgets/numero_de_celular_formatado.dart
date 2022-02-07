import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/global/location_state.dart';

class NumeroDeCelularFormatadoEEmNegrito extends StatelessWidget {
  NumeroDeCelularFormatadoEEmNegrito({
    Key? key,
  }) : super(key: key);

  final LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(
        () {
          var formattedNumber = locationController.phoneNumberInputController.value.text.replaceAll('(', '').replaceAll('-', '').replaceAll(' ', '').replaceAll(')', '');
          return Text(
            formattedNumber,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          );
        },
      ),
    );
  }
}
