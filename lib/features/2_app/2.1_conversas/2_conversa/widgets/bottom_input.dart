import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/path_cubit.dart';

class BottomInputBar extends StatelessWidget {
  const BottomInputBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(tag: context.read<PathCubit>().state);

    return SizedBox(
      height: 55,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
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
                          Get.to(
                            () => Scaffold(
                              appBar: AppBar(),
                              body: Column(
                                children: [
                                  Image.file(
                                    File(image.path),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      conversaController.route;
                                      var ref = FirebaseStorage.instance.ref('${conversaController.route}/${const Uuid().v4()}');
                                      try {
                                        ref.putFile(File(image.path)).then(
                                          (p0) async {
                                            var path = await p0.ref.getDownloadURL();
                                            sendMessage(path: conversaController.route, mensagem: '', mediaLink: path);
                                          },
                                        );
                                      } catch (e) {
                                        Get.defaultDialog(
                                          title: 'ERROR - ${e.toString()}',
                                          content: Image.file(
                                            File(image.path),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text("Send"),
                                  )
                                ],
                              ),
                            ),
                          );
                          return;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            CircleAvatar(
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
            ),
          ],
        ),
      ),
    );
  }

  Future<XFile?> getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 500, maxHeight: 500, imageQuality: 50);
    return image;
  }
}

void sendMessage({
  required String path,
  required String mensagem,
  String mediaLink = '',
}) {
  var realtime = FirebaseDatabase.instance;
  var conversaGeral = realtime.ref(path);
  var hoje = DateTime.now();
  double ano = hoje.year * 3.154e10;
  double mes = hoje.month * 2.628e9;
  double dia = hoje.day * 8.64e7;
  double hora = hoje.hour * 3.6e6;
  double minuto = hoje.minute * 60000;
  double segundos = hoje.second * 1000;
  int millissegundos = hoje.millisecond;
  int agora = (ano + mes + dia + hora + minuto + segundos + millissegundos).toInt();

  conversaGeral.child(agora.toString()).set({
    "mensagem": mensagem,
    "date": DateTime.now().toString(),
    'usuario': FirebaseAuth.instance.currentUser?.phoneNumber.toString() ?? 'UNDEFINED',
    'mediaLink': mediaLink
  });
}