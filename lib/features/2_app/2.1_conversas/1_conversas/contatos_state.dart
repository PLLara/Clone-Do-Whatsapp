// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/widgets/scaffold_loading.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp2/common/state/contacts_state.dart';

class Contatos extends StatelessWidget {
  ContactsController contactsController = Get.find();

  Contatos({
    Key? key,
  }) : super(key: key) {
    contactsController.getContactsFromDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => load());
  }

  Widget load() {
    var contacts = contactsController.contatos;

    if (contactsController.contatos.isEmpty) {
      return const ScaffoldLoading();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Contatos"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            Contact contact = contacts[index];
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (e)=>UserDescription(contact: contact)));
              },
              leading: UserPhoto(contact: contact),
              title: Text(contact.displayName),
            );
          },
        ),
      );
    }
  }
}

class UserDescription extends StatelessWidget {
  const UserDescription({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: UserPhoto(contact: contact),
      ),
    );
  }
}

class UserPhoto extends StatelessWidget {
  const UserPhoto({
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
    // TODO: Replace Column with actual stock image :)
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
    return Hero(
      tag: 'Image',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.memory(contact.photoOrThumbnail!, width: 41),
      ),
    );
  }
}
