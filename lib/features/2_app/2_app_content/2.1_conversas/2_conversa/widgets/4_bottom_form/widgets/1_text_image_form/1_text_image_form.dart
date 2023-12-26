// ignore_for_file: file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/4_bottom_form/widgets/1_text_image_form/widgets/get_image_from_gallery.dart';

import '../../../../../../../../../state/local/conversa_state.dart';
import '../../../../state/path_cubit.dart';

class TextImageForm extends StatefulWidget {
  const TextImageForm({
    super.key,
  });

  @override
  State<TextImageForm> createState() => _TextImageFormState();
}

class _TextImageFormState extends State<TextImageForm> {
  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state.conversaId,
    );

    return Expanded(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xff202C33),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    if (conversaController.emojiKeyboardClosed.value) {
                      conversaController.focusNode.requestFocus();
                      await Future.delayed(const Duration(milliseconds: 100));
                      conversaController.emojiKeyboardClosed.value = false;
                    } else {
                      conversaController.focusNode.unfocus();
                      await Future.delayed(const Duration(milliseconds: 100));
                      conversaController.emojiKeyboardClosed.value = true;
                    }
                  },
                  icon: const Icon(Icons.emoji_emotions, color: Colors.grey),
                ),
                const TextImageFormText(),
                const TextImageFormImage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextImageFormText extends StatelessWidget {
  const TextImageFormText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state.conversaId,
    );

    return Flexible(
      flex: 5,
      child: TextField(
        controller: conversaController.sendMessageController,
        focusNode: conversaController.focusNode,
        textInputAction: TextInputAction.done,
        onSubmitted: (e) {
          if (conversaController.sendMessageController.text.trim() != '') {
            sendMessage(
              path: conversaController.route,
              mensagem: conversaController.sendMessageController.text,
              mediaLink: '',
            );
            conversaController.sendMessageController.clear();
            conversaController.focusNode.requestFocus();
          }
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Mensagem',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TextImageFormImage extends StatelessWidget {
  const TextImageFormImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        GetImageFromGallery(),
      ],
    );
  }
}

Future<TaskSnapshot> sendImageToFirebase(Reference ref, XFile image) async {
  var result = await ref.putData(
    await image.readAsBytes(),
    SettableMetadata(
      contentType: 'image/jpeg',
    ),
  );
  return result;
}

void sendMessage({
  required String path,
  required String mensagem,
  String? mediaLink = '',
}) async {
  print("Enviando mensagem");
  var usuario = FirebaseAuth.instance.currentUser?.phoneNumber;
  var parsedPath = "$path/${DateTime.now().millisecondsSinceEpoch}";
  var eita = DateTime.now().toLocal().toString();
  var tempo = eita.split(" ")[1];
  var dias = eita.split(" ")[0].split("/").reversed.join("-");
  var parsedData = "$dias $tempo";
  FirebaseDatabase.instance.ref().child(parsedPath).set({
    "date": parsedData,
    "mediaLink": mediaLink ?? "",
    "mensagem": mensagem,
    "usuario": usuario,
  });
}

Future<XFile?> getImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    maxWidth: 500,
    maxHeight: 500,
    imageQuality: 50,
  );
  return image;
}

Future<XFile?> getVideoFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickVideo(
    source: ImageSource.camera,
  );
  return image;
}
