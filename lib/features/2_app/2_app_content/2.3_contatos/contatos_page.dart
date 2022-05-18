// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.3_contatos/widgets/1_contacts_loading_screen/contacts_loading_screen_widget.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.3_contatos/widgets/contacts_list_view/contacts_list_view_widget.dart';

import '../../../../state/contacts_state.dart';

class Contatos extends StatelessWidget {
  ContactsController contactsController = Get.find();

  Contatos({
    Key? key,
  }) : super(key: key) {
    // * Get Contacts from device if contact list is empty, else, do nothing (:
    contactsController.contatos.isEmpty ? contactsController.getContactsFromDevice() : null;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => load());
  }

  Widget load() {
    var contacts = contactsController.contatos;
    if (contacts.isEmpty || contacts.length == 1) {
      return const ContactsLoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: ContactsListView(
        contacts: contacts,
      ),
    );
  }
}
