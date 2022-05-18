import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/state/conversa_state.dart';

enum Status { waiting, success, empty }

class ConversasPathController extends GetxController {
  ConversasPathController() {
    setPathListener();
  }

  RxList<ConversaPathData> conversas = <ConversaPathData>[].obs;
  Rx<Status> status = Status.waiting.obs;
  late StreamSubscription conversasStream;

  setPathListener() async {
    Print.magenta("---------- INITIALIZING PATH CONVERSAS CONTROLLER LISTENER ----------");

    var myPhoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber ?? '';
    var conversasSnapshots = FirebaseFirestore.instance.collection('conversas').where('participantes', arrayContains: myPhoneNumber).snapshots();
    conversasStream = conversasSnapshots.listen(
      (event) async {
        List<ConversaPathData> newConversas = [];
        for (var newConversa in event.docs) {
          var pNewConversa = newConversa.data();
          var iParticipateInConversa = (pNewConversa['participantes'] as List<dynamic>).contains(myPhoneNumber);
          if (iParticipateInConversa) {
            Print.green("${pNewConversa['']} ${pNewConversa['participantes']} contains $myPhoneNumber");
            var newConversaPathData = ConversaPathData(
              criadorNumber: myPhoneNumber,
              conversaId: newConversa.id,
              titulo: pNewConversa['titulo'],
              descricao: pNewConversa['descricao'],
              criadorId: pNewConversa['criador'],
              thumbnail: pNewConversa['thumbnail'],
              isConversaPrivate: pNewConversa['personal'],
              participantes: pNewConversa['participantes'].cast<String>() as List<String>,
            );
            newConversas.add(
              newConversaPathData,
            );
            Print.green("NEW CONVERSA ADDED: " + newConversaPathData.toString());
          }
        }
        var conversaIdList = conversas.map((element) => element.conversaId).toList();
        var newConversasIdList = newConversas.map((element) => element.conversaId).toList();
        List<String> idsToRemove = conversaIdList.toSet().difference(newConversasIdList.toSet()).toList();

        Print.green("---------- CONVERSAS LISTENER FIRED ----------");
        for (var conversaId in idsToRemove) {
          try {
            Print.magenta("CANCELANDO LISTENER DA CONVERSA: " + conversaId);
            var conversaController = Get.find<ConversaController>(tag: conversaId);
            conversaController.cancelStream();
            conversaController.dispose();
          } catch (e) {}
        }

        conversas.removeRange(0, conversas.length);
        conversas.addAll(newConversas);
        update();
      },
    );
  }

  void addConversaGeral() {
    for (var conversa in conversas) {
      if (conversa.conversaId == 'geral') {
        return;
      }
    }
    conversas.add(
      ConversaPathData(
        criadorNumber: '',
        conversaId: 'geral',
        titulo: 'Conversa Geral',
        descricao: ':)',
        criadorId: 'asd',
        thumbnail: '',
        isConversaPrivate: false,
        participantes: [],
      ),
    );
  }

  void removeConversa(String conversaId, bool isConversaPrivate) async {
    Print.red("REMOVING CONVERSA: " + conversaId);
    var conversaController = Get.find<ConversaController>(tag: conversaId);
    try {
      conversaController.dispose();
    } catch (e) {
      Print.red("CONTROLLER ALREADY DISPOSED");
    }

    if (isConversaPrivate) {
      await FirebaseFirestore.instance.collection("conversas").doc(conversaId).delete();
    }
    for (var conversa in conversas) {
      if (conversa.conversaId == conversaId) {
        conversas.remove(conversa);
        return;
      }
    }
  }

  void removeConversaGeral() {
    Print.red("REMOVING CONVERSA: GERAL");
    try {
      Get.find<ConversaController>(tag: 'geral').dispose();
    } catch (e) {
      Print.red("CONTROLLER ALREADY DISPOSED");
    }

    for (var conversa in conversas) {
      if (conversa.conversaId == 'geral') {
        conversas.remove(conversa);
        return;
      }
    }
  }

  addNewPath({
    required String titulo,
    required List<String> participantes,
    String descricao = '',
    bool personal = false,
    String? thumbnail,
  }) async {
    var creatorPhoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
    if (creatorPhoneNumber == null) {
      return;
    }
    participantes.add(creatorPhoneNumber);
    await FirebaseFirestore.instance.collection('conversas').add({
      'titulo': titulo,
      'descricao': descricao,
      'criador': FirebaseAuth.instance.currentUser?.uid,
      'thumbnail': thumbnail,
      'participantes': participantes,
      'personal': personal,
    });
  }
}

class ConversaPathData {
  String conversaId;
  String criadorId;
  String criadorNumber;
  String titulo;
  String descricao;
  List<String> participantes;
  bool isConversaPrivate;
  dynamic thumbnail;
  ConversaPathData({
    required this.conversaId,
    required this.criadorId,
    required this.criadorNumber,
    required this.titulo,
    required this.descricao,
    required this.participantes,
    required this.isConversaPrivate,
    required this.thumbnail,
  });

  ConversaPathData copyWith({
    String? conversaId,
    String? criadorId,
    String? criadorNumber,
    String? titulo,
    String? descricao,
    List<String>? participantes,
    bool? personal,
    dynamic? thumbnail,
  }) {
    return ConversaPathData(
      conversaId: conversaId ?? this.conversaId,
      criadorId: criadorId ?? this.criadorId,
      criadorNumber: criadorNumber ?? this.criadorNumber,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      participantes: participantes ?? this.participantes,
      isConversaPrivate: personal ?? this.isConversaPrivate,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conversaId': conversaId,
      'criadorId': criadorId,
      'criadorNumber': criadorNumber,
      'titulo': titulo,
      'descricao': descricao,
      'participantes': participantes,
      'personal': isConversaPrivate,
      'thumbnail': thumbnail,
    };
  }

  factory ConversaPathData.fromMap(Map<String, dynamic> map) {
    return ConversaPathData(
      conversaId: map['conversaId'],
      criadorId: map['criadorId'],
      criadorNumber: map['criadorNumber'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      participantes: List<String>.from(map['participantes']),
      isConversaPrivate: map['personal'],
      thumbnail: map['thumbnail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversaPathData.fromJson(String source) => ConversaPathData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConversaPathData(conversaId: $conversaId, criadorId: $criadorId, criadorNumber: $criadorNumber, titulo: $titulo, descricao: $descricao, participantes: $participantes, personal: $isConversaPrivate, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConversaPathData && other.conversaId == conversaId && other.criadorId == criadorId && other.criadorNumber == criadorNumber && other.titulo == titulo && other.descricao == descricao && listEquals(other.participantes, participantes) && other.isConversaPrivate == isConversaPrivate && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return conversaId.hashCode ^ criadorId.hashCode ^ criadorNumber.hashCode ^ titulo.hashCode ^ descricao.hashCode ^ participantes.hashCode ^ isConversaPrivate.hashCode ^ thumbnail.hashCode;
  }
}
