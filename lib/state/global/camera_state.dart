import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CameraStateController extends GetxController {
  RxList<CameraDescription> cameras = List<CameraDescription>.of([]).obs;
  Rx<CameraController> controller = CameraController(
    const CameraDescription(
      lensDirection: CameraLensDirection.back,
      name: '',
      sensorOrientation: 2,
    ),
    ResolutionPreset.high,
  ).obs;

  CameraStateController() {
    // initCameras();
  }

  initCameras() async {
    try {
      availableCameras().then(
        (cameras) async {
          var newController = controller.value = CameraController(
            cameras[cameras.length - 1],
            ResolutionPreset.low,
          );
          await newController.initialize();
          controller.value = newController;
          update();

          // ! Defining variables
          var dbImageReference = FirebaseStorage.instance.ref('teste/${FirebaseAuth.instance.currentUser?.phoneNumber}@${const Uuid().v4()}');
          var capturedImage = await controller.value.takePicture();
          // ! Fazendo o upload da imagem e criando o widget da imagem
          if (kIsWeb) {
            Uint8List? imageBytes = (await http.get(Uri.parse(capturedImage.path))).bodyBytes;
            dbImageReference.putData(imageBytes, SettableMetadata(contentType: 'image/png'));
          } else {
            dbImageReference.putFile(
              File(capturedImage.path),
            );
          }
        },
      );
    } catch (e) {
      cameras.value = [];
      update();
    }
  }
}
