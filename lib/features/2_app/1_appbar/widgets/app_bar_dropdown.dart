import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/navigator/go_to_page.dart';
import 'package:whatsapp2/common/themes/unavailable_text.dart';
import 'package:whatsapp2/features/2_app/1_appbar/1_appbar_widget.dart';
import 'package:whatsapp2/features/2_app/3_configuracoes/configuracoes_widget.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';

class AppBarDropDown extends StatelessWidget {
  const AppBarDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (optionSelected) {
        switch (optionSelected) {
          case 'config':
            goToPage(
              const Configuracoes(
                key: Key('config'),
              ),
              Get.to,
            );
            break;
          case 'testlab':
            goToPage(
              const TestLab(
                key: Key('testlab'),
              ),
              Get.to,
            );
            break;
          case 'danger':
            Get.find<ConversasPathController>().addConversaGeral();
            break;
          default:
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyLarge,
          value: 'newGroup',
          child: const Text(
            'Novo Grupo',
          ),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyLarge,
          value: 'favorites',
          child: Text(
            'Mensagens Favoritas',
            style: getUnavailableTextTheme(context),
          ),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyLarge,
          value: 'danger',
          child: const Text(
            'Liberar conversa geral',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyLarge,
          value: 'testlab',
          child: const Text('TestLab'),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyLarge,
          value: 'config',
          child: const Text('Configurações'),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyLarge,
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
