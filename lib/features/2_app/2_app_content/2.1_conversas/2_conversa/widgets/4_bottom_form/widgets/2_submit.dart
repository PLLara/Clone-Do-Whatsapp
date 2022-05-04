// ignore_for_file: implementation_imports, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';

import '../../../state/conversa_state.dart';
import '../../../state/path_cubit.dart';
import '1_text_image_form.dart';

class Submit extends StatelessWidget {
  const Submit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state.conversaId,
    );
    return CircleAvatar(
      backgroundColor: const Color(0xff00A884),
      radius: 20,
      child: IconButton(
        padding: const EdgeInsets.all(5),
        icon: const Icon(Icons.send),
        color: Colors.white,
        onPressed: () {
          if (conversaController.controller.text.trim() != '') {
            sendMessage(
              path: conversaController.route,
              mensagem: conversaController.controller.text,
            );
            conversaController.controller.clear();
          }
        },
      ),
    );
  }
}
