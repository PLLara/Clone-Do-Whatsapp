// ignore_for_file: file_names, avoid_print, library_prefixes
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as getxTransitions;
import 'package:whatsapp2/state/local/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/state/path_cubit.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/4_bottom_form/widgets/1_text_image_form/1_text_image_form.dart';

class GetImageFromGallery extends StatelessWidget {
  const GetImageFromGallery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state.conversaId,
    );
    return Transform.rotate(
      angle: -3.14 / 4,
      child: IconButton(
        color: Colors.grey,
        icon: const Icon(Icons.attach_file),
        onPressed: () async {
          XFile? image = await getImageFromGallery();
          if (image == null) {
            Print.red("---------- DEU RUIM ---------");
            return;
          }
          var imagefile = await image.readAsBytes();
          Get.to(
            () => Scaffold(
              appBar: AppBar(),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: Image.memory(imagefile)),
                  BlocProvider.value(
                    value: context.read<PathCubit>(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        TextImageForm(),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      String mensagem = conversaController.sendMessageController.text;
                      conversaController.sendMessageController.clear();

                      var ref = FirebaseStorage.instance.ref('conversas/${conversaController.route}/${const Uuid().v4()}');
                      try {
                        TaskSnapshot result = await sendImageToFirebase(ref, image);
                        var path = await result.ref.getDownloadURL();
                        sendMessage(
                          path: conversaController.route,
                          mensagem: mensagem,
                          mediaLink: path,
                        );
                        Print.green("--------- DEU BOM ${conversaController.route} $path} ---------");
                      } catch (e) {
                        Get.defaultDialog(
                          title: 'ERROR - ${e.toString()}',
                          content: Image.memory(await image.readAsBytes()),
                        );
                      }
                    },
                    child: const Text("Send"),
                  ),
                ],
              ),
            ),
            transition: getxTransitions.Transition.topLevel,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
