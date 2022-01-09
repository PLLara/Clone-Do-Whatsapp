import 'package:flutter_contacts/flutter_contacts.dart';

Future<List<Contact>> getContacts() async {
  if (await FlutterContacts.requestPermission()) {
    List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
    return contacts;
  } else {
    return [];
  }
}