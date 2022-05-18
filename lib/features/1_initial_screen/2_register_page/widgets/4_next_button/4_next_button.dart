// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state/location_state.dart';
import '../5_confirm_number_dialog/5_confirm_number_dialog.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.find();

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
        );
      },
      child: const Text('Próximo'),
    );
  }
}
