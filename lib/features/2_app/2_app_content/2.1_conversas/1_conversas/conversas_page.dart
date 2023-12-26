// ignore_for_file: avoid_print, non_constant_identifier_names, must_be_immutable, avoid_unnecessary_containers, invalid_use_of_protected_member

// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/1_conversas/widgets/1_lista_de_conversas_widget.dart';
import 'package:whatsapp2/state/global/contacts_state.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';

class Conversas extends StatelessWidget {
  Conversas({
    super.key,
  });

  final ConversasPathController pathConversasController = Get.find();
  final ContactsController contactsController = Get.find<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // * Setting variables:
        var conversas = pathConversasController.conversas;
        if (conversas.isEmpty) {
          return const SemConversasCriarNovaWidget();
        }

        return ListView.builder(
          itemCount: conversas.length,
          itemBuilder: (_, index) {
            return ConversaListTile(
              conversaPath: conversas[index],
            );
          },
        );
      },
    );
  }
}
