import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/3_configuracoes/configuracoes_widget.dart';

import '../../../2_app_content/2.1_conversas/1_conversas/state/conversas_state.dart';
import '../1_appbar_widget.dart';

class AppBarDropDown extends StatelessWidget {
  const AppBarDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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

        if (e == 'danger') {
          Get.find<PathConversasController>().addConversaGeral();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyText1,
          value: 'newGroup',
          child: const Text('Novo Grupo'),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyText1,
          value: 'favorites',
          child: const Text('Mensagens Favoritas'),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyText1,
          value: 'danger',
          child: const Text(
            'Liberar conversa geral',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyText1,
          value: 'TestLab',
          child: const Text('TestLab'),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyText1,
          value: 'Config',
          child: const Text('Configurações'),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyText1,
          value: 'Sair',
          child: const Text('Sair'),
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
}
