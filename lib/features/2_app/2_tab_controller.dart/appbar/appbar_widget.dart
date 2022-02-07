// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
