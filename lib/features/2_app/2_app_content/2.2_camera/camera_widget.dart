import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({
    Key? key,
  }) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? controller;

  @override
  void initState() {
    List<CameraDescription> cameras;
    try {
      availableCameras().then(
        (value) {
          cameras = value;
          controller = CameraController(
            cameras[cameras.length - 1],
            ResolutionPreset.low,
          );
          controller?.initialize().then(
            (_) {
              if (!mounted) {
                return;
              }
              setState(() {});
            },
          );
        },
      );
    } catch (e) {
      cameras = [];
      controller = null;
    }

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return const Center(
        child: Text("Camera não disponível!"),
      );
    }
    return MaterialApp(
      home: Stack(
        children: [
          CameraPreview(
            controller!,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TakePicture(
                controller: controller,
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

  final CameraController? controller;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        var file = await controller?.takePicture();

        if (file != null) {
          Get.defaultDialog(
            title: file.path,
            content: Image.file(
              File(
                file.path,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Share.shareFiles([
                    file.path
                  ], text: 'eu amo o vitao');
                },
                child: const Text("ENVIAR"),
              )
            ],
          );

        } else {

          Get.defaultDialog(
            title: "Camera Error!",
          );
          
        }
      },
      child: const Text('FOTO'),
    );
  }
}
