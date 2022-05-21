import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';

class UserDescription extends StatelessWidget {
  UserDescription({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final ConversasPathController pathConversasController = Get.find();
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserPhotoOrPlaceholder(contact: contact),
            Text(contact.displayName),
            const Divider(),
            Column(
              children: [
                for (var x in contact.phones) Text(x.number)
              ],
            ),
            TextButton(
              onPressed: () async {
                //* Go back to initial screen
                Get.back();
                Get.back();
                await pathConversasController.addNewPath(
                  titulo: contact.displayName,
                  participantes: [
                    contact.phones[0].number
                  ],
                  personal: true,
                );
              },
              child: const Text('Criar conversa'),
            )
          ],
        ),
      ),
    );
  }
}

class UserPhotoOrPlaceholder extends StatelessWidget {
  const UserPhotoOrPlaceholder({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    if (contact.photoOrThumbnail != null) {
      return PhotoFromUser(contact: contact);
    } else {
      return const PlaceholderPhotoFromUser();
    }
  }
}

class PlaceholderPhotoFromUser extends StatelessWidget {
  const PlaceholderPhotoFromUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(Icons.person),
        ),
      ],
    );
  }
}

class PhotoFromUser extends StatelessWidget {
  const PhotoFromUser({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.memory(contact.photoOrThumbnail!, width: 40),
    );
  }
}
