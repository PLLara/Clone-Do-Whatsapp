// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:whatsapp2/common/widgets/loading.dart';

class ContactsLoadingScreen extends StatelessWidget {
  const ContactsLoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Loading(),
          const Center(
            child: Text('Carregando contatos...'),
          ),
          TextButton(onPressed: () {}, child: const Text('Caçar alguém pelo número')),
        ],
      ),
    );
  }
}
