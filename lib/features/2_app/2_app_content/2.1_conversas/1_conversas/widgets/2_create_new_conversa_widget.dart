// ignore_for_file: avoid_print, non_constant_identifier_names, must_be_immutable, avoid_unnecessary_containers, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/navigator/go_to_page.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.3_contatos/contatos_page.dart';

class CreateNewConversaWidget extends StatelessWidget {
  const CreateNewConversaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.message,
        color: Colors.white,
      ),
      onPressed: () {
        goToPage(Contatos(), Get.to);
      },
    );
  }
}
