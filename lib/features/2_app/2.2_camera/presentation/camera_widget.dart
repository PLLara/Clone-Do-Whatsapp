import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class CameraApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraApp({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    List<CameraDescription> cameras = widget.cameras;
    super.initState();
    controller = CameraController(cameras[1], ResolutionPreset.low);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Column(
        children: [
          CameraPreview(
            controller,
          ),
          TextButton(
            onPressed: () async {
              var file = await controller.takePicture();
              Get.defaultDialog(
                actions: [
                  TextButton(
                    onPressed: () {
                      Share.shareFiles([
                        file.path
                      ], text: 'eu amo o vitao');
                    },
                    child: Text("ENVIAR"),
                  )
                ],
                title: file.path,
                content: Image.file(
                  File(
                    file.path,
                  ),
                ),
              );
            },
            child: Text('FOTO'),
          ),
        ],
      ),
    );
  }
}
