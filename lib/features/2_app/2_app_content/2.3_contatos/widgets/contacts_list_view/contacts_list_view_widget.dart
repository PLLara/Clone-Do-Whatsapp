import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.3_contatos/widgets/contacts_list_view/widgets/user_description_widget.dart';
import '../../../../../../common/functions/temzap2.dart';
import '../../../2.1_conversas/1_conversas/state/conversas_state.dart';

class ContactsListView extends StatelessWidget {
  final List<Contact> contacts;
  const ContactsListView({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = contacts[index];
        return ContactListTile(contact: contact);
      },
    );
  }
}

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showUserDescription(context);
      },
      leading: UserPhotoOrPlaceholder(contact: contact),
      title: Text(contact.displayName),
      trailing: Text(
        temZap2(contact) ? 'ZAP2' : '',
        style: const TextStyle(
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  void showUserDescription(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => UserDescription(
          contact: contact,
          key: Key(contact.phones[0].number),
        ),
      ),
    );
  }
}
