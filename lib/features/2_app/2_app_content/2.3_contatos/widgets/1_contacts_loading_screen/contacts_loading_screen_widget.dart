// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/state/location_state.dart';
import 'package:whatsapp2/features/1_initial_screen/2_register_page/widgets/2_form/2_cellphone_number_form.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';

class ContactsLoadingScreen extends StatelessWidget {
  const ContactsLoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Nenhum contato encontrado"),
            TextButton(
              onPressed: () {
                Get.to(
                  Scaffold(
                    appBar: AppBar(),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Chame alguém pelo número", style: Theme.of(context).textTheme.headline2),
                        ControlledFormLoginPhoneNumber(),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (e) {
                                return const AddConversaDialog();
                              },
                            );
                          },
                          child: const Text("Iniciar"),
                        )
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Criar conversa pelo número'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddConversaDialog extends StatelessWidget {
  const AddConversaDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConversasPathController pathConversasController = Get.find();
    final LocationController locationController = Get.find();
    var parsedPhoneNumber = "+55" + locationController.phoneNumberInputController.value.text.replaceAll('(', '').replaceAll('-', '').replaceAll(' ', '').replaceAll(')', '');
    var myPhoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber ?? '';

    return AlertDialog(
      title: const Text("Iniciar conversa"),
      content: Text(parsedPhoneNumber.toString()),
      actions: [
        myPhoneNumber == parsedPhoneNumber
            ? const Text("Esse é o seu numero!")
            : ElevatedButton(
                onPressed: () async {
                  Get.back();
                  Get.back();
                  Get.back();
                  await pathConversasController.addNewConversa(
                    titulo: "",
                    participantes: [
                      parsedPhoneNumber
                    ],
                    personal: true,
                  );
                },
                child: const Text(
                  "Iniciar Conversa",
                ),
              )
      ],
    );
  }
}
