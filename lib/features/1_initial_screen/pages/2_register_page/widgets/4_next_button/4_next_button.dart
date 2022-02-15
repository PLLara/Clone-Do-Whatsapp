// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/global/location_state.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/2_register_page/widgets/5_confirm_number_dialog/5_confirm_number_dialog.dart';

class NextButton extends StatelessWidget {
  NextButton({
    Key? key,
  }) : super(key: key);
  final LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
      onPressed: () {
        var oTamanhoDoNumeroForPequenoDemais = locationController.phoneNumberInputController.value.text.length < 10;
        if (oTamanhoDoNumeroForPequenoDemais) {
          Get.defaultDialog(
            title: "Insira um número válido",
            content: const Text(
              "O numero fornecido possui menos de 10 caracteres.",
              textAlign: TextAlign.center,
            ),
          );
          return;
        }

        Get.dialog(
          DialogoDeConfirmacaoDeNumero(
            key: const Key('dialogoconfirmacaonumero'),
          ),
          barrierDismissible: false,
        );
      },
      child: const Text('Próximo'),
    );
  }
}
