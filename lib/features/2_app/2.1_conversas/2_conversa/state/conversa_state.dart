// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum States { loading, ready, error }

class ConversaController extends GetxController {
  final reference = FirebaseDatabase.instance.ref('conversas/geral');

  start() async {
    print("-----------------------------------------------INICIANDO A PORRA DO STATE");

    state.value = States.loading;
    var x = await reference.once();
    var lista = [];
    x.snapshot.children.toList().forEach((element) {
      lista.add(element.value);
    });
    papo.addAll(lista);
    sort();
    state.value = States.ready;
    print(papo);
    startStream();
  }

  startStream() {
    dataStream = reference.orderByKey().limitToLast(1).onValue.listen((event) {
      print(event.snapshot.children.last.value);
      if (event.snapshot.value != null && iniciado.value) {
        papo.insert(0, event.snapshot.children.last.value);
      }
      iniciado.value = true;
    });
  }

  sort() {
    papo.sort(
      (a, b) {
        var dateA = DateTime.parse(a['date']);
        var dateB = DateTime.parse(b['date']);
        return dateB.compareTo(dateA);
      },
    );
  }

  final Rx<States> state = States.ready.obs;
  late final StreamSubscription<DatabaseEvent> dataStream;
  final TextEditingController controller = TextEditingController();
  final RxList<dynamic> papo = [].obs;
  final RxBool iniciado = false.obs;
}
