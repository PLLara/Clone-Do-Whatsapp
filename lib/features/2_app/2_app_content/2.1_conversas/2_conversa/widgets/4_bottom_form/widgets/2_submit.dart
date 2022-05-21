// ignore_for_file: implementation_imports, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';

import '../../../../../../../../state/local/conversa_state.dart';
import '../../../state/path_cubit.dart';
import '1_text_image_form/1_text_image_form.dart';

class Submit extends StatelessWidget {
  const Submit({Key? key, this.optionalMediaLink}) : super(key: key);

  final String? optionalMediaLink;

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state.conversaId,
    );
    return CircleAvatar(
      backgroundColor: const Color(0xff00A884),
      radius: 23,
      child: IconButton(
        iconSize: 22,
        icon: Container(
          padding: const EdgeInsets.only(left: 3.0),
          child: const Icon(Icons.send_rounded),
        ),
        color: Colors.white,
        onPressed: () {
          if (conversaController.sendMessageController.text.trim() != '') {
            sendMessage(
              path: conversaController.route,
              mensagem: conversaController.sendMessageController.text,
              mediaLink: optionalMediaLink,
            );
            conversaController.sendMessageController.clear();
          }
        },
      ),
    );
  }
}
