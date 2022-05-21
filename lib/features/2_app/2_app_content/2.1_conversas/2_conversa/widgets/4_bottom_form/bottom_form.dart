import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
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
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state.conversaId,
    );

    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                TextAndImageForm(),
                Submit(),
              ],
            ),
          ),
          Obx(
            () => Offstage(
              offstage: !conversaController.emojiKeyboardClosed.value,
              child: SizedBox(
                height: 250,
                child: EmojiPicker(
                  onEmojiSelected: (Category category, Emoji emoji) {
                    _onEmojiSelected(emoji, conversaController.sendMessageController);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
