// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import '../../features/2_app/2_app_content/2.1_conversas/1_conversas/data/contacts_source.dart';

class ContactsController extends GetxController {
  RxList<Contact> contatos = <Contact>[].obs;
  ContactsController() {
    getContactsFromDevice();
  }

  getContactsFromDevice() async {
    List<Contact> contacts = [];
    try {
      contacts = await getContacts();
    } catch (e) {
      print(e);
    }
    for (var contact in contacts) {
      contact.websites = [];
      contact.isStarred = false;
    }

    FirebaseFirestore.instance.collection('usuarios').get().then((value) {
      for (var doc in value.docs) {
        for (var contact in contacts) {
          var numberList = contact.phones.map((e) {
            var number = e.number;
            if (number.length < 7) {
              number = 'TEM NUMERO NAO :)';
            }
            return number.substring(number.length - 8);
          }).toList();
          var dbNumber = doc.data()['numero'] ?? 'VISH CADE O NUMERO?';
          dbNumber = dbNumber.substring(dbNumber.length - 8);
          if (numberList.contains(dbNumber)) {
            contact.websites.add(Website('whatsapp2.com'));
          }
        }
      }
      contatos.sort((a, b) {
        return b.websites.length.compareTo(a.websites.length);
      });
      contatos.addAll(contacts);
      update();
    });

    setContacts(contacts);
  }

  setContacts(List<Contact> newContacts) {
    contatos.removeRange(0, contatos.length);
    contatos.addAll(newContacts);
  }
}
