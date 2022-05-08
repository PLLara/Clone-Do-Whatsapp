// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/state/user_state.dart';
import '../../features/2_app/2_app_content/2.1_conversas/1_conversas/data/contacts_source.dart';
import 'package:http/http.dart' as http;

class ContactsController extends GetxController {
  RxList<Contact> contatos = <Contact>[].obs;
  ContactsController() {
    print('initializing contacts controller');
  }

  getContactsFromDevice() async {
    List<Contact> contacts = [];
    setContacts(contacts);
    try {
      contacts = await getContacts();
    } catch (e) {
      print(e);
    }
    for (var contact in contacts) {
      contact.websites = [];
      contact.isStarred = false;
    }

    var myPhoneNumber = Get.find<UserController>().user.value?.phoneNumber;
    if (myPhoneNumber == null) {
      return;
    }
    myPhoneNumber = myPhoneNumber.substring(myPhoneNumber.length - 8);

    for (var contact in contacts) {
      if (contact.phones.isEmpty) {
        continue;
      }
      if (contact.phones[0].number.contains(myPhoneNumber)) {
        contacts.remove(contact);
        break;
      }
    }
    setContacts(contacts);

    FirebaseFirestore.instance.collection('usuarios').get().then((value) async {
      for (var doc in value.docs) {
        for (var contact in contacts) {
          // * Pegando a lista de numeros do usuario
          var numberList = contact.phones.map((e) {
            e.number = e.number.replaceAll('-', '');
            e.number = e.number.replaceAll(' ', '');
            var number = e.number;
            if (number.length < 7) {
              number = 'TEM NUMERO NAO :)';
            }
            var normalizedNumber = number.substring(number.length - 8);

            return normalizedNumber;
          }).toList();

          // * Verificando se cada numero tem zap 2
          var dbNumber = doc.data()['numero'] ?? 'VISH CADE O NUMERO?';
          dbNumber = dbNumber.substring(dbNumber.length - 8);
          if (numberList.contains(dbNumber)) {
            contact.websites.add(Website('whatsapp2.com'));
            if (doc.data()['foto'] != null) {
              var imageData = (await http.get(
                Uri.parse(doc.data()['foto']),
              ));
              contact.photo = imageData.bodyBytes;
            }
          } else {}
        }
      }
      contatos.sort((a, b) {
        return b.websites.length.compareTo(a.websites.length);
      });
      update();
    });
  }

  setContacts(List<Contact> newContacts) {
    contatos.removeRange(0, contatos.length);
    contatos.addAll(newContacts);
  }
}
