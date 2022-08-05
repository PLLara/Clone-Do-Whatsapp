// ignore_for_file: file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/4_bottom_form/widgets/1_text_image_form/widgets/get_image_from_gallery.dart';
import '../../../../../../../../../state/local/conversa_state.dart';
import '../../../../state/path_cubit.dart';

class TextAndImageForm extends StatefulWidget {
  const TextAndImageForm({
    Key? key,
  }) : super(key: key);

  @override
  State<TextAndImageForm> createState() => _TextAndImageFormState();
}

class _TextAndImageFormState extends State<TextAndImageForm> {
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
                const GetTexto(),
                const GetAnexos()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GetTexto extends StatelessWidget {
  const GetTexto({
    Key? key,
  }) : super(key: key);

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
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class GetAnexos extends StatelessWidget {
  const GetAnexos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: const [
        GetImageFromGallery(),
      ],
    );
  }
}

Future<TaskSnapshot> sendImageToFirebase(Reference ref, XFile image) async {
  TaskSnapshot result = await ref.putData(
    await image.readAsBytes(),
    SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {
        "Access-Control-Allow-Origin": "*"
      },
    ),
  );
  return result;
}

void sendMessage({
  required String path,
  required String mensagem,
  String? mediaLink = '',
}) async {
  var usuario = FirebaseAuth.instance.currentUser?.phoneNumber;
  if (usuario == null) {
    return print("Error");
  }

  var uri = 'https://whatsappi-2.uc.r.appspot.com/sendMessage';
  await http.post(Uri.parse(uri), body: {
    "path": path,
    "mensagem": mensagem,
    "usuario": usuario,
    "mediaLink": mediaLink ?? ''
  });
}

Future<XFile?> getImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(
    source: ImageSource.gallery,
    maxWidth: 500,
    maxHeight: 500,
    imageQuality: 50,
  );
  return image;
}

Future<XFile?> getVideoFromGallery() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickVideo(
    source: ImageSource.camera,
  );
  return image;
}
