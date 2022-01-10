import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp2/features/conversas/data/contacts_provider.dart';

class ContactsController extends GetxController{
  RxList<Contact> contatos = <Contact>[].obs;

  getContactsFromDevice() async{
    List<Contact> newContacts = await getContacts();
    setContacts(newContacts);
  }

  setContacts(List<Contact> newContacts){
    contatos.removeRange(0, contatos.length);
    contatos.addAll(newContacts);
  }
}