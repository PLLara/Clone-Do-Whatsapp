import 'package:flutter_contacts/flutter_contacts.dart';

Future<List<Contact>> getContacts() async {
  var x = await FlutterContacts.requestPermission();
  if (x) {
    List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
    return contacts;
  } else {
    return [
      Contact(name: Name(first: "Error"))
    ];
  }
}
