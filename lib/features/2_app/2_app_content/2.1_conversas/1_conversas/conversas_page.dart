// ignore_for_file: avoid_print, non_constant_identifier_names, must_be_immutable, avoid_unnecessary_containers, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/1_conversas/widgets/2_create_new_conversa_widget.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/1_conversas/widgets/1_lista_de_conversas_widget.dart';

class Conversas extends StatelessWidget {
  const Conversas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121B22),
      body: ConversationsList(),
      floatingActionButton: const CreateNewConversaWidget(),
    );
  }
}
