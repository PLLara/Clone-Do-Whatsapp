import 'package:flutter_contacts/contact.dart';

bool temZap2(Contact contact) {
  for (var x in contact.websites) {
    if (x.url == 'whatsapp2.com') {
      return true;
    }
  }
  return false;
}
