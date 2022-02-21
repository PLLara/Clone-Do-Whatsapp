import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_contacts/properties/group.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/1_conversas/data/contacts_source.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactsController extends GetxController {
  RxList<Contact> contatos = <Contact>[].obs;

  getContactsFromDevice() async {
    var alreadyExistingUsersResponse = await http.get(Uri.parse('https://whatsapp-2-backend.herokuapp.com/getallusers'));

    var alreadyExistingUsersNumberList = [];
    var parsedAlreadyUsers = json.decode(alreadyExistingUsersResponse.body);
    if (parsedAlreadyUsers['status'] == 'success') {
      var userList = parsedAlreadyUsers['payload'] as Iterable;
      for (var element in userList) {
        alreadyExistingUsersNumberList.add(element['fone'] as String);
      }
    }

    try {
      List<Contact> newContacts = await getContacts();

      for (var e in newContacts) {
        if (e.phones.isNotEmpty) {
          if (alreadyExistingUsersNumberList.contains(e.phones[0].normalizedNumber)) {
            print("${e.displayName} TEM ZAP 2 HAHAHAHAH");
            e.websites = [
              Website('whatsapp2.com')
            ];
          }
        }
      }

      newContacts.sort((a,b){
        return b.websites.length.compareTo(a.websites.length);
      });

      setContacts(newContacts);
    } catch (e) {
      print(e);
      setContacts([
        Contact()
      ]);
    }
  }

  setContacts(List<Contact> newContacts) {
    contatos.removeRange(0, contatos.length);
    contatos.addAll(newContacts);
  }
}
