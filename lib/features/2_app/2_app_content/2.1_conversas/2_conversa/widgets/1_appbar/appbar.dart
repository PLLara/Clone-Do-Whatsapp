// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';

AppBar ConversaAppBarBind({
  required Widget injectedConversaPhoto,
  required Widget injectedTitle,
}) {
  return AppBar(
    backgroundColor: const Color(0xff1F2C34),
    leadingWidth: 80,
    leading: TextButton(
      onPressed: () {
        Get.find<DesktopSelectedConversaController>().clearSelectedWidget();
        Get.back();
      },
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          injectedConversaPhoto,
        ],
      ),
    ),
    title: injectedTitle,
    actions: [
      PopupMenuButton(
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
            child: const Text(':)'),
            onTap: () {},
          ),
        ],
      ),
    ],
  );
}
