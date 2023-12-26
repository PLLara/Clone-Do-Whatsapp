// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:whatsapp2/common/functions/internet.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/1_conversas/data/contacts_source.dart';
import 'package:whatsapp2/model/conversa.dart';

class ContactsController extends GetxController {
  RxList<Contact> contatos = <Contact>[].obs;

  @override
  onInit() {
    getContactsFromDevice();
    super.onInit();
  }

  getContactsFromDevice() async {
    Print.magenta('---------- INITIALIZING CONTACTS CONTROLLER ---------');

    // * Definindo as variáveis
    List<Contact> newContatos = [];
    String? myPhoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
    if (contatos.isNotEmpty || myPhoneNumber == null) return; //! Se a função ja tiver sido executada ou ocorrer algum problema com meu numero de telefone, não execute.

    try {
      newContatos = await getContacts();
    } catch (e) {
      print(e);
    }
    newContatos = parseContatosList(newContatos, myPhoneNumber);
    var voce = Contact();
    voce.displayName = 'Você';
    voce.name = Name(first: 'Você');
    voce.phones = [
      Phone(myPhoneNumber)
    ];
    newContatos.add(voce);

    // * Por fim, pegue as informações da web e aplique nos contatos
    syncContactsFromDeviceWithWebInfo(newContatos);
  }

  void syncContactsFromDeviceWithWebInfo(List<Contact> newContatos) {
    CollectionReference<Map<String, dynamic>> contatosCollection = FirebaseFirestore.instance.collection('usuarios');
    // TODO: Código bagunçado
    contatosCollection.get().then((contatoSnapshot) async {
      for (var contato in contatoSnapshot.docs) {
        var dbNumber = contato.data()['numero'] ?? 'VISH CADE O NUMERO?';
        var photoUrl = contato.data()['foto'];

        for (var contact in newContatos) {
          // * Pegando e normalizando a lista de numeros do usuario
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
          dbNumber = dbNumber.substring(dbNumber.length - 8);
          if (numberList.contains(dbNumber)) {
            contact.websites.add(Website('whatsapp2.com'));
            if (photoUrl != null) {
              Uint8List? imageData = await Internet.getCachedImageBytes(contato.data()['foto']);
              contact.photo = imageData;
            }
          }
        }
      }
      newContatos.sort((a, b) {
        return b.websites.length.compareTo(a.websites.length);
      });
      setContacts(newContatos);
    });
  }

  setContacts(List<Contact> newContacts) {
    contatos.removeRange(0, contatos.length);
    if (newContacts.isEmpty) {
      return contatos.add(Contact());
    }
    contatos.addAll(newContacts);
  }

  Contact procurarContatoDoDestinatario(ConversaPathData path, Contact otherPessoa) {
    try {
      path.participantes.remove(path.criadorNumber);
      var otherPessoaNumber = path.participantes[0];

      for (var contact in contatos) {
        for (var element in contact.phones) {
          var parsedNumber = element.number.replaceAll(' ', '').replaceAll('-', '');
          if (parsedNumber == otherPessoaNumber) {
            otherPessoa = contact;
          }
        }
      }
      if (otherPessoa.displayName == '') {
        otherPessoa.displayName = getNameBasedOnNumber(path.participantes[0]);
      }
      return otherPessoa;
    } catch (e) {
      print(e);
      return otherPessoa;
    }
  }

  getNameBasedOnNumber(String number) {
    for (var contact in contatos) {
      for (var phone in contact.phones) {
        if (parseNumber(phone.number) == number) {
          return contact.displayName;
        }
      }
    }
    return number;
  }
}

String parseNumber(String number) => number.replaceAll('-', '').replaceAll(' ', '');

List<Contact> parseContatosList(List<Contact> newContatos, String myPhoneNumber) {
  for (var contact in newContatos) {
    contact.websites = [];
    contact.isStarred = false;
  }
  myPhoneNumber = myPhoneNumber.substring(myPhoneNumber.length - 8);
  newContatos = newContatos.where((contact) {
    if (contact.phones.isEmpty) {
      return true;
    }
    if (parseNumber(contact.phones[0].number).contains(myPhoneNumber)) {
      return false;
    }
    return true;
  }).toList();
  return newContatos;
}
