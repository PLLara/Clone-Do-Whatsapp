import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Configuracoes extends StatelessWidget {
  const Configuracoes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    var phoneNumber = (currentUser?.phoneNumber ?? '').toString();
    var name = currentUser?.displayName;
    var asd = currentUser?.metadata;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name ?? 'SEM NOME AINDA'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(asd?.creationTime.toString() ?? 'SEM DESCRIÇÃO'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.red,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  onTap: () {},
                  hoverColor: Colors.red,
                  focusColor: Colors.red,
                  leading: const SizedBox(
                    width: 40,
                    child: Center(
                      child: Icon(Icons.person_add),
                    ),
                  ),
                  title: const Text("TESTE"),
                  subtitle: const Text("ASDASDASDASD"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
