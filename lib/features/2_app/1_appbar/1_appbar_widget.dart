// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp2/common/themes/default.dart';
import 'package:whatsapp2/features/2_app/1_appbar/widgets/app_bar_dropdown.dart';
import 'package:whatsapp2/features/2_app/1_appbar/widgets/search_conversas.dart';

AppBar MyAppBar(myTabs) {
  return AppBar(
    actions: const [
      SearchInConversas(),
      AppBarDropDown(),
    ],
    title: const Text(
      "Clone do Zap",
      style: TextStyle(color: Colors.grey),
    ),
    bottom: TabBar(
      indicatorColor: defaultDarkTheme().primaryColor,
      labelColor: defaultDarkTheme().primaryColor,
      unselectedLabelColor: Colors.white,
      physics: const ClampingScrollPhysics(),
      tabs: [
        for (var tab in myTabs) tab.myTab
      ],
    ),
  );
}

class FileManager extends StatefulWidget {
  final List<FileSystemEntity> entities;
  const FileManager({super.key, required this.entities});

  @override
  State<FileManager> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.entities[0].uri.toFilePath(),
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
            Get.back();
          },
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: widget.entities.length,
          itemBuilder: (e, a) {
            var entitie = widget.entities[a];
            return ListTile(
              leading: IconFileAccordingToFileType(entitie: entitie),
              onTap: () {
                if (entitie is Directory) {
                  getDir(entitie.path);
                  return;
                }
                // File arquivo = File(entitie.path);
                OpenFile.open(entitie.path);
              },
              title: Text(
                (entitie.path.split('/').last == '' ? '..' : entitie.path.split('/').last),
              ),
            );
          },
        ),
      ),
    );
  }
}

class IconFileAccordingToFileType extends StatelessWidget {
  final FileSystemEntity entitie;
  const IconFileAccordingToFileType({super.key, required this.entitie});

  @override
  Widget build(BuildContext context) {
    if (entitie is Directory) {
      return const Icon(Icons.folder);
    }
    if (isImage(entitie)) {
      return Image.file(
        File(entitie.path),
        scale: 0.01,
        width: 50,
        height: 50,
      );
    }

    return const Icon(Icons.description);
  }
}

bool isImage(FileSystemEntity entitie) {
  if (entitie is Directory) {
    return false;
  }
  if (entitie.path.endsWith('jpg') || entitie.path.endsWith('jpeg') || entitie.path.endsWith('png') || entitie.path.endsWith('webp')) {
    return true;
  }
  return false;
}

class TestLab extends StatelessWidget {
  const TestLab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var paths = [
      [
        'root',
        'storage/emulated/0/'
      ],
      [
        'DCIM',
        'storage/emulated/0/DCIM'
      ],
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          for (var path in paths)
            TextButton(
              onPressed: () {
                Get.back();
                Get.to(Scaffold(
                  appBar: AppBar(),
                ));
                getDir(
                  path[1],
                  first: true,
                );
              },
              child: Text(
                path[0],
              ),
            ),
        ],
      ),
    );
  }
}

Future<void> getDir(String path, {first = false}) async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }

  if (!status.isGranted) {
    return;
  }

  final dir = Directory(path);
  final List<FileSystemEntity> entities = dir.listSync();

  var lastPath = path.replaceAll(path.split('/').last, '');
  entities.insert(0, Directory(lastPath));

  if (!first) {
    Get.back();
  }
  Get.to(
    () => FileManager(
      key: Key(path),
      entities: entities,
    ),
    transition: Transition.fadeIn,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
}
