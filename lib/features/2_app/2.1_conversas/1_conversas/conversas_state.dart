// ignore_for_file: avoid_print, non_constant_identifier_names, must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/1_conversas/contatos_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/conversa_page.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/conversa_state.dart';

class Conversas extends StatelessWidget {
  const Conversas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ConversasPageContent();
  }
}

class ConversasPageContent extends StatelessWidget {
  const ConversasPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ConversationsList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(
            () => Contatos(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}

class ConversationsList extends StatelessWidget {
  const ConversationsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var conversas = [
      'conversas/geral',
      'conversas/geral2',
      'conversas/geral3',
    ];

    return ListView.builder(
      itemCount: conversas.length,
      itemBuilder: (_, index) {
        DateTime _now = DateTime.now();
        return ConversaOpenerTile(now: _now, path: conversas[index]);
      },
    );
  }
}

class ConversaOpenerTile extends StatelessWidget {
  const ConversaOpenerTile({Key? key, required DateTime now, required this.path})
      : _now = now,
        super(key: key);

  final DateTime _now;
  final String path;

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.put(
      ConversaController(route: path),
      permanent: true,
      tag: path,
    );

    if (conversaController.iniciado.value != true) {
      conversaController.start();
    }

    var icon = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(Icons.person),
        ),
      ],
    );

    return ListTile(
      onTap: () async {
        conversaController.quantidadeDeMensagensNaoLidas.value = 0;
        Get.to(
          () => Conversa(
            tag: path,
          ),
          transition: Transition.topLevel,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      leading: icon,
      title: Text(
        conversaController.route,
      ),
      subtitle: const Text("whatsapp2"),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${_now.hour}:${_now.minute}',
            style: TextStyle(
              color: context.theme.primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            constraints: const BoxConstraints(
              minHeight: 18,
              minWidth: 18,
              maxWidth: 18,
            ),
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Obx(
                  () => Text(
                    conversaController.quantidadeDeMensagensNaoLidas.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
