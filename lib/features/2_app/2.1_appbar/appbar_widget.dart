// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp2/common/themes/default.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:whatsapp2/features/2_app/3_configuracoes/configuracoes_widget.dart';

AppBar MyAppBar(myTabs) {
  return AppBar(
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      PopupMenuButton(
        onSelected: (e) {
          if (e == 'Config') {
            Get.to(
              () => const Configuracoes(
                key: Key('config'),
              ),
              transition: Transition.topLevel,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }

          if (e == 'TestLab') {
            Get.to(
              () => const TestLab(
                key: Key("testlab"),
              ),
            );
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          const PopupMenuItem(
            value: 'newGroup',
            child: Text('Novo Grupo'),
          ),
          const PopupMenuItem(
            value: 'favortes',
            child: Text('Mensagens Favoritas'),
          ),
          const PopupMenuItem(
            value: 'TestLab',
            child: Text('TestLab'),
          ),
          const PopupMenuItem(
            value: 'Config',
            child: Text('Configurações'),
          ),
          PopupMenuItem(
            value: 'Sair',
            child: const Text('Sair'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    ],
    title: const Text("Whatsapp 2"),
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

  const FileManager({Key? key, required this.entities}) : super(key: key);

  @override
  State<FileManager> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  Future<Widget> getIcon(FileSystemEntity entitie) async {
    if (entitie is Directory) {
      return const Icon(Icons.folder);
    }
    if (entitie.path.endsWith('jpg') || entitie.path.endsWith('jpeg') || entitie.path.endsWith('png') || entitie.path.endsWith('webp')) {
      return Image.file(
        File(entitie.path),
        scale: 0.01,
        width: 50,
        height: 50,
      );
    }

    return Icon(Icons.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: widget.entities.length,
          itemBuilder: (e, a) {
            var entitie = widget.entities[a];
    
            return ListTile(
              leading: FutureBuilder(
                future: getIcon(entitie),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data as Widget;
                  }
                  return Loading();
                },
              ),
              onTap: () {
                if (entitie is Directory) {
                  getDir(entitie.path);
                  return;
                }
                File arquivo = File(entitie.path);
                OpenFile.open(entitie.path);
              },
              title: Text(entitie.path.split('/').last),
            );
          },
        ),
      ),
    );
  }
}

getDir(String path, {first = false}) async {
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
  Get.to(()=>
    FileManager(
      key: Key(path),
      entities: entities,
    ),
  );
}

class TestLab extends StatelessWidget {
  const TestLab({
    Key? key,
  }) : super(key: key);

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
                getDir(path[1], first: true);
              },
              child: Text(path[0]),
            ),
        ],
      ),
    );
  }
}
