// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar ConversaAppBarBind() {
  return AppBar(
    leadingWidth: 80,
    leading: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.person),
              ),
            ],
          ),
        ],
      ),
    ),
    title: const Text("Conversa Geral"),
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
