// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:whatsapp2/features/1_initial_screen/global/location_state.dart';
import 'package:whatsapp2/common/widgets/show_fatal_error.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/2_register_page/widgets/5_confirm_number_dialog/state/verify_phone_number.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/2_register_page/widgets/5_confirm_number_dialog/widgets/botao_de_voltar.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/2_register_page/widgets/5_confirm_number_dialog/widgets/numero_de_celular_formatado.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/3_confirm_number_page/3_confirm_number_page.dart';

class DialogoDeConfirmacaoDeNumero extends StatefulWidget {
  DialogoDeConfirmacaoDeNumero({
    Key? key,
  }) : super(key: key);

  final LocationController locationController = Get.find();

  @override
  State<DialogoDeConfirmacaoDeNumero> createState() => _DialogoDeConfirmacaoDeNumeroState();
}

class _DialogoDeConfirmacaoDeNumeroState extends State<DialogoDeConfirmacaoDeNumero> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: loading ? const Loading() : const ConfirmNumberDialogContent(),
      actions: loading
          ? [
              const SizedBox()
            ]
          : ActionsList(context),
    );
  }

  List<Widget> ActionsList(BuildContext context) {
    var parsedPhoneNumber = "+55" + widget.locationController.phoneNumberInputController.value.text.replaceAll('(', '').replaceAll('-', '').replaceAll(' ', '').replaceAll(')', '');

    return [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Row(
          children: [
            const BotaoDeVoltar(),
            const Expanded(
              child: SizedBox(),
            ),
            TextButton(
              onPressed: () {
                setState(
                  () {
                    loading = true;
                  },
                );
                verifyPhoneNumber(
                  phoneNumber: parsedPhoneNumber,
                  onCodeSend: (String verificationId, int? resendToken) async {
                    Get.back();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ConfirmNumberPage(
                            key: const Key('confirmnumberpage'),
                            verificationId: verificationId,
                          );
                        },
                      ),
                    );
                  },
                  onProblem: (FirebaseAuthException e) {
                    showFatalError(e);
                  },
                );
              },
              child: const Text("Confirmar"),
            ),
          ],
        ),
      ),
    ];
  }
}

class ConfirmNumberDialogContent extends StatelessWidget {
  const ConfirmNumberDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Você escolheu o número: ",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        NumeroDeCelularFormatadoEEmNegrito(),
        Text(
          "Tem certeza que esse é o número certo?",
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
