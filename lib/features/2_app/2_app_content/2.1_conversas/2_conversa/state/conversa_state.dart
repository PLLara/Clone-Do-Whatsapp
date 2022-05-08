// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/model/message_model.dart';

enum States { loading, ready, error }

class ConversaController extends GetxController {
  final String route;
  late final StreamSubscription<DatabaseEvent> addedValueStream;
  late final StreamSubscription<DatabaseEvent> removedValueStream;
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    addedValueStream.cancel();
    removedValueStream.cancel();
    controller.dispose();
    super.dispose();
  }

  final Rx<States> state = States.ready.obs;

  final RxList<MessageModel> papo = <MessageModel>[].obs;
  final RxBool iniciado = false.obs;

  final RxInt quantidadeDeMensagensNaoLidas = 0.obs;

  ConversaController({required this.route});

  messageWasAdded() {
    quantidadeDeMensagensNaoLidas.value += 1;
  }

  MessageModel parseMessage(DataSnapshot element) {
    try {
      if (element.key != null) {
        var parsedValue = (element.value as Map);
        return MessageModel(
          id: element.key ?? 'error',
          date: DateTime.parse(parsedValue['date']),
          message: parsedValue['mensagem'] ?? 'ERROR',
          mediaLink: parsedValue['mediaLink'] ?? 'ERROR',
          usuario: parsedValue['usuario'] ?? 'ERROR',
        );
      } else {
        print("!!!!!!!!!!ERROR!!!!!!!!!!!!");
        return MessageModel(
          id: 'ERROR-ERROR-ERROR',
          date: DateTime.now(),
          message: 'ERROR-ERROR-ERROR',
          mediaLink: 'ERROR-ERROR-ERROR',
          usuario: 'ERROR-ERROR-ERROR',
        );
      }
    } catch (e) {
      print(e.toString());

      return MessageModel(
        id: 'ERROR-ERROR-ERROR',
        date: DateTime.now(),
        message: 'ERROR-ERROR-ERROR',
        mediaLink: 'ERROR-ERROR-ERROR',
        usuario: 'ERROR-ERROR-ERROR',
      );
    }
  }

  start() async {
    iniciado.value = true;
    final reference = FirebaseDatabase.instance.ref(route);
    print("-------------------INICIANDO DO STATE--------------------------");

    state.value = States.loading;
    var ref = await reference.once();
    var lista = <MessageModel>[];

    ref.snapshot.children.toList().forEach(
      (element) {
        messageWasAdded();
        lista.add(parseMessage(element));
      },
    );

    papo.addAll(lista);
    sort();
    state.value = States.ready;
    startStream();
  }

  startStream() {
    final reference = FirebaseDatabase.instance.ref(route);

    addedValueStream = reference.orderByKey().limitToLast(1).onValue.listen((event) {
      bool seEuDeveriaAdicionarAMensagem(DatabaseEvent event) => event.snapshot.value != null && iniciado.value;
      if (seEuDeveriaAdicionarAMensagem(event)) {
        Print.green("----- MESSAGE ADDED -----");
        papo.insert(0, parseMessage(event.snapshot.children.last));
      }
      messageWasAdded();
    });

    removedValueStream = reference.onChildRemoved.listen(
      (event) {
        MessageModel? messageToBeRemoved;

        for (MessageModel legal in papo) {
          if (legal.id == parseMessage(event.snapshot).id) {
            print("----- MESSAGE REMOVED -----");
            messageToBeRemoved = legal;
          }
        }
        if (messageToBeRemoved != null) {
          papo.remove(messageToBeRemoved);
        }
      },
    );
  }

  sort() {
    papo.sort(
      (a, b) {
        var dateA = DateTime.parse(a.date.toString());
        var dateB = DateTime.parse(b.date.toString());
        return dateB.compareTo(dateA);
      },
    );
  }
}
