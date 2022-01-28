// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/conversa_state.dart';

class ConversaGeral extends StatefulWidget {
  const ConversaGeral({
    Key? key,
  }) : super(key: key);

  @override
  State<ConversaGeral> createState() => _ConversaGeralState();
}

class _ConversaGeralState extends State<ConversaGeral> {
  final ConversaController conversaController = Get.find<ConversaController>();

  @override
  void initState() {
    super.initState();
    print("...CONFIGURANDO O LISTENER PARA OS DADOS...");
    conversaController.dataStream.resume();
  }

  @override
  void dispose() async {
    super.dispose();
    conversaController.dataStream.pause();
    print("...INSCRIÇÃO FECHADA...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              Column(
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
              ),
            ],
          ),
        ),
        title: const Text("Conversa Geral"),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: const Text(':)'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              child: Obx(
                () => ListView.builder(
                  reverse: true,
                  itemCount: conversaController.papo.length,
                  itemBuilder: (e, index) {
                    return MensagemWidget(
                      conversaController.papo.value[index],
                      key: Key(conversaController.papo.value[index]['usuario'] + conversaController.papo.value[index]['mensagem']),
                    );
                  },
                ),
              ),
            ),
          ),
          BottomInputBar()
        ],
      ),
    );
  }
}

class MensagemWidget extends StatelessWidget {
  final dynamic mensagem;

  MensagemWidget(
    this.mensagem, {
    Key? key,
  }) : super(key: key);
  final ConversaController conversaController = Get.find<ConversaController>();

  @override
  Widget build(BuildContext context) {
    if (mensagem['usuario'] == FirebaseAuth.instance.currentUser?.phoneNumber) {
      return Padding(
        padding: const EdgeInsets.only(left: 60),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 1,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff005C4B),
                  ),
                  child: Text(
                    mensagem['mensagem'],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 60),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff202C33),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(mensagem['usuario'] + ": " + mensagem['mensagem']),
            ),
          ),
        ],
      ),
    );
  }
}

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
                      child: Container(
                        child: TextField(
                          controller: conversaController.controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Mensagem',
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(),
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
                    conversaGeral.child(const Uuid().v4()).set({
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
