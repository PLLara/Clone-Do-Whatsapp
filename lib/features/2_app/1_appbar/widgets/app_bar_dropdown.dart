import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/navigator/go_to_page.dart';
import 'package:whatsapp2/common/themes/unavailable_text.dart';
import 'package:whatsapp2/features/2_app/1_appbar/1_appbar_widget.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/1_conversas/state/conversas_state.dart';
import 'package:whatsapp2/features/2_app/3_configuracoes/configuracoes_widget.dart';
import 'package:whatsapp2/state/contacts_state.dart';

class AppBarDropDown extends StatelessWidget {
  const AppBarDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (e) {
        if (e == 'Config') {
          goToPage(
              const Configuracoes(
                key: Key('config'),
              ),
              Get.to);
        }

        if (e == 'TestLab') {
          goToPage(
              const TestLab(
                key: Key("testlab"),
              ),
              Get.to);
        }

        if (e == 'danger') {
          Get.find<ConversasPathController>().addConversaGeral();
        }
        if (e == 'clear_contacts') {
          Get.find<ContactsController>().setContacts([]);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyText1,
          value: 'newGroup',
          child: Text(
            'Novo Grupo',
            style: getUnavailableTextTheme(context),
          ),
        ),
        PopupMenuItem(
          textStyle: Theme.of(context).textTheme.bodyText1,
          value: 'favorites',
          child: Text(
            'Mensagens Favoritas',
            style: getUnavailableTextTheme(context),
          ),
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
