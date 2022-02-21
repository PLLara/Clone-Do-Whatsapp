import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:provider/src/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/path_cubit.dart';
import 'package:http/http.dart' as http;

class TextAndImageForm extends StatelessWidget {
  const TextAndImageForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state.conversaId,
    );

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xff202C33),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.emoji_emotions),
            ),
            Flexible(
              flex: 2,
              child: TextField(
                controller: conversaController.controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Mensagem',
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.photo),
                onPressed: () async {
                  XFile? image = await getImageFromGallery();
                  if (image == null) {
                    return;
                  }

                  var imagefile = await image.readAsBytes();
                  Get.to(
                    () {
                      return Scaffold(
                        appBar: AppBar(),
                        body: Column(
                          children: [
                            Image.memory(imagefile),
                            TextButton(
                              onPressed: () async {
                                Get.back();
                                conversaController.route;
                                var ref = FirebaseStorage.instance.ref('${conversaController.route}/${const Uuid().v4()}');
                                try {
                                  ref.putData(await image.readAsBytes(),SettableMetadata(
                                    contentType: 'image/jpeg',
                                    customMetadata: {
                                      "Access-Control-Allow-Origin": "*"
                                    }

                                  )).then(
                                    (result) async {
                                      var path = await result.ref.getDownloadURL();
                                      sendMessage(
                                        path: conversaController.route,
                                        mensagem: '',
                                        mediaLink: path,
                                      );
                                    },
                                  );
                                } catch (e) {
                                  Get.defaultDialog(
                                    title: 'ERROR - ${e.toString()}',
                                    content: Image.memory(await image.readAsBytes()),
                                  );
                                }
                              },
                              child: const Text("Send"),
                            )
                          ],
                        ),
                      );
                    },
                  );
                  return;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

void sendMessage({
  required String path,
  required String mensagem,
  String mediaLink = '',
}) async {
  var usuario = FirebaseAuth.instance.currentUser?.phoneNumber;
  if (usuario == null) {
    return print("Error");
  }

  var uri = 'https://whatsapp-2-backend.herokuapp.com/sendMessage';

  await http.post(Uri.parse(uri),body: {
    "path":path,
    "mensagem": mensagem,
    "usuario": usuario,
    "mediaLink":mediaLink
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
