// ignore_for_file: avoid_print, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/conversas/presentation/state/contacts_state.dart';
import 'package:whatsapp2/features/conversas/presentation/widgets/contatos.dart';

class Conversas extends StatelessWidget {
  ContactsController contactsController = Get.put(ContactsController()); // Rather Controller controller = Controller();

  Conversas({
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
        onPressed: () => Get.to(
          Contatos(),
          transition: Transition.topLevel,
          duration: const Duration(milliseconds: 500),
        ),
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
      itemBuilder: (_, a) {
        DateTime _now = DateTime.now();
        var title = a.toString() + "ASDASDASDA";
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
              () => Scaffold(
                appBar: AppBar(
                  leading: TextButton(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Row(
                    children: [
                      Column(
                        children: [
                          Text(title),
                          const Text("+12312123123"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              transition: Transition.topLevel,
              duration: Duration(milliseconds: 500),
            );
          },
          leading: icon,
          title: Text(
            title,
          ),
          subtitle: const Text("whatsapp2"),
          trailing: Container(
            child: Column(
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
          ),
        );
      },
    );
  }
}
