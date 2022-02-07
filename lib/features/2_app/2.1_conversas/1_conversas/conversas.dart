// ignore_for_file: avoid_print, non_constant_identifier_names, must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/1_conversas/state/contacts_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/1_conversas/contatos.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/conversa_page.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/conversa_state.dart';

class Conversas extends StatelessWidget {
  final ConversaController conversaController = Get.find<ConversaController>();

  Conversas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (conversaController.state.value == States.loading) {
        return const Loading();
      }
      return const ConversasPageContent();
    });
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
            Contatos(),
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
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (_, a) {
        DateTime _now = DateTime.now();
        var title = "Conversa Geral";
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
            Get.to(
              const ConversaGeral(),
              transition: Transition.topLevel,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          leading: icon,
          title: Text(
            title,
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
                    Text(
                      a.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
