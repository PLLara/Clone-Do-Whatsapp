import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/1_conversas/contacts_provider.dart';

class ContactsController extends GetxController{
  RxList<Contact> contatos = <Contact>[].obs;

  getContactsFromDevice() async{
    print(":)");
    List<Contact> newContacts = await getContacts();
    setContacts(newContacts);
  }

  setContacts(List<Contact> newContacts){
    contatos.removeRange(0, contatos.length);
    contatos.addAll(newContacts);
  }
}