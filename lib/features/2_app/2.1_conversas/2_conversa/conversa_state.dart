// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConversaController extends GetxController {
  ConversaController() {
    dataStream = FirebaseDatabase.instance.ref('conversas/geral').onChildAdded.listen((event) {
      print('Snapshot: ${event.snapshot.value}');
      papo.add(event.snapshot.value);
      papo.sort((a, b) {
        var dateA = DateTime.parse(a['date']);
        var dateB = DateTime.parse(b['date']);
        return dateB.compareTo(dateA);
      });
    });

    
  }

  late final StreamSubscription<DatabaseEvent> dataStream;
  final TextEditingController controller = TextEditingController();
  final RxList<dynamic> papo = [].obs;
}
