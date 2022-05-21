import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math; // import this

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController? cameraController;

  @override
  void initState() {
    availableCameras().then((cameras) {
      var newController = CameraController(
        cameras[0],
        ResolutionPreset.low,
      );
      Print.green(newController.toString());
      newController.initialize().then((e) {
        setState(() {
          cameraController = newController;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null) {
      return const Loading();
    }
    return MaterialApp(
      home: Stack(
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: CameraPreview(
              cameraController!,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TakePicture(
                controller: cameraController!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TakePicture extends StatelessWidget {
  const TakePicture({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        ElevatedButton(
          onPressed: () async {
            try {
              // ! Defining variables
              var dbImageReference = FirebaseStorage.instance.ref('teste/${FirebaseAuth.instance.currentUser?.phoneNumber}@${const Uuid().v4()}');
              var capturedImage = await controller.takePicture();
              Image imagem;

              // ! Fazendo o upload da imagem e criando o widget da imagem
              Print.green("---------- FOTO TIRADA : ${capturedImage.path} ----------");
              if (kIsWeb) {
                Uint8List? imageBytes = (await http.get(Uri.parse(capturedImage.path))).bodyBytes;
                dbImageReference.putData(imageBytes, SettableMetadata(contentType: 'image/png')).then((p0) {
                  dbImageReference.getDownloadURL().then((value) => print(value));
                });
                imagem = Image.network(capturedImage.path);
              } else {
                dbImageReference.putFile(
                  File(capturedImage.path),
                );
                imagem = Image.file(File(capturedImage.path));
              }
              Get.defaultDialog(
                title: capturedImage.path,
                content: imagem,
                actions: [
                  TextButton(
                    onPressed: () {
                      Share.shareFiles([
                        capturedImage.path
                      ], text: 'eu amo o vitao');
                    },
                    child: const Text("ENVIAR"),
                  )
                ],
              );
            } catch (e) {
              Print.red("---------- ERRO AO SALVAR IMAGEM $e ---------");
            }
          },
          child: const Text('Tirar foto'),
        ),
      ],
    );
  }
}
