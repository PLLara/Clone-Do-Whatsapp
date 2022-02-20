// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/path_cubit.dart';

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
    title: BlocBuilder<PathCubit, String>(
      builder: (context, state) {
        return Text(state);
      },
    ),
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
