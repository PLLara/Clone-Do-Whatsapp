import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/state/local/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/state/path_cubit.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/4_bottom_form/widgets/1_text_image_form/1_text_image_form.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/4_bottom_form/widgets/2_submit.dart';

class BottomForm extends StatefulWidget {
  const BottomForm({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomForm> createState() => _BottomFormState();
}

class _BottomFormState extends State<BottomForm> {
  _onEmojiSelected(Emoji emoji, TextEditingController _controller) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    // !
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state.conversaId,
    );

    // *
    if (kIsWeb) {
      return Container(
        color: const Color(0xff202C33),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
            const TextImageFormImage(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 40, 54, 62),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: const [
                    TextImageFormText(),
                  ],
                ),
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
          ],
        ),
      );
    }
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                TextImageForm(),
                Submit(),
              ],
            ),
          ),
          Obx(
            () {
              if (kIsWeb) {
                return Offstage(
                  offstage: !conversaController.emojiKeyboardClosed.value,
                  child: Container(
                    color: conversaController.emojiKeyboardClosed.value ? Colors.black : Colors.white,
                    child: const Text("SISTEMA DE EMOGI NÃO IMPLEMENTADO NA WEB ):"),
                  ),
                );
              }
              return Offstage(
                offstage: !conversaController.emojiKeyboardClosed.value,
                child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                    onEmojiSelected: (category, Emoji emoji) {
                      _onEmojiSelected(emoji, conversaController.sendMessageController);
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
