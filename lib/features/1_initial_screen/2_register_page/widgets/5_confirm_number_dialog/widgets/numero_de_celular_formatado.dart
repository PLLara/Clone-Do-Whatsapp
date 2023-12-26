import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../state/location_state.dart';

class NumeroDeCelularFormatadoEEmNegrito extends StatelessWidget {
  NumeroDeCelularFormatadoEEmNegrito({
    super.key,
  });

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
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}
