// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../2.1_conversas/1_conversas/conversas.dart';
import '../2.2_camera/presentation/camera_widget.dart';

class Home extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Home(this.cameras, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<TabData> myTabs = [
      TabData(
        myTab: const Tab(
          text: 'Conversas',
        ),
        myWidget: Conversas(),
      ),
            TabData(
        myTab: const Tab(
          text: 'Status',
        ),
        myWidget: Scaffold(
          body: Center(child: Text(":)")),
        ),
      ),
      TabData(
        myTab: const Tab(
          text: '📷︎',
        ),
        myWidget: CameraApp(
          cameras: widget.cameras,
        ),
      ),
    ];
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(myTabs),
        body: TabBarView(
          physics: const ClampingScrollPhysics(),
          children: [
            for (var tab in myTabs) tab.myWidget
          ],
        ),
      ),
      length: myTabs.length,
    );
  }

  AppBar MyAppBar(myTabs) {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        PopupMenuButton(
          onSelected: (e) {
            if (e == 'Config') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (e) => const Configuracoes(
                    key: Key('config'),
                  ),
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
              value: 'Config',
              child: Text('Configurações'),
            ),
            PopupMenuItem(
              value: 'Config',
              child: Text('Sair'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ],
      title: const Text("Whatsapp 2"),
      bottom: TabBar(
        indicatorColor: Colors.yellow,
        labelColor: Colors.yellow,
        unselectedLabelColor: Colors.white,
        physics: const ClampingScrollPhysics(),
        tabs: [
          for (var tab in myTabs) tab.myTab
        ],
      ),
    );
  }
}

class Configuracoes extends StatelessWidget {
  const Configuracoes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    var phoneNumber = (currentUser?.phoneNumber ?? '').toString();
    var name = currentUser?.displayName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name ?? 'SEM NOME AINDA'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(name ?? 'SEM DESCRIÇÃO'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.red,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  onTap: () {},
                  hoverColor: Colors.red,
                  focusColor: Colors.red,
                  leading: SizedBox(
                    width: 40,
                    child: Center(
                      child: Icon(Icons.person_add),
                    ),
                  ),
                  title: Text("TESTE"),
                  subtitle: Text("ASDASDASDASD"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TabData {
  final Tab myTab;
  final Widget myWidget;
  TabData({
    required this.myTab,
    required this.myWidget,
  });
}
