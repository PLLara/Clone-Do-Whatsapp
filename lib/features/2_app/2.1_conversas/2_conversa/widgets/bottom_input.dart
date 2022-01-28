import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/conversa_state.dart';

class BottomInputBar extends StatelessWidget {
  BottomInputBar({
    Key? key,
  }) : super(key: key);
  final ConversaController conversaController = Get.find<ConversaController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.emoji_emotions),
                    ),
                    Flexible(
                      flex: 2,
                      child: TextField(
                        controller: conversaController.controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mensagem',
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.photo),
                          onPressed: (){},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 20,
              child: IconButton(
                padding: const EdgeInsets.all(5),
                icon: const Icon(Icons.send),
                color: Colors.white,
                onPressed: () {
                  if (conversaController.controller.text.trim() != '') {
                    var realtime = FirebaseDatabase.instance;
                    var conversaGeral = realtime.ref('conversas/geral');
                    var hoje = DateTime.now();
                    double ano = hoje.year * 3.154e10;
                    double mes = hoje.month * 2.628e9;
                    double dia = hoje.day * 8.64e7;
                    double hora = hoje.hour * 3.6e6;
                    double minuto = hoje.minute * 60000;
                    double segundos = hoje.second * 1000;
                    int millissegundos = hoje.millisecond;
                    int agora = (ano+mes+dia+hora+minuto+segundos+millissegundos).toInt();

                    conversaGeral.child(agora.toString()).set({
                      "mensagem": conversaController.controller.text,
                      "date": DateTime.now().toString(),
                      'usuario': FirebaseAuth.instance.currentUser?.phoneNumber.toString() ?? 'UNDEFINED'
                    });
                    conversaController.controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
