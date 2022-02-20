import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/path_cubit.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/widgets/4_bottom_form/widgets/1_text_image_form.dart';

class Submit extends StatelessWidget {
  const Submit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state,
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
