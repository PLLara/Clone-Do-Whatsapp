import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/conversa_page.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';
import 'package:whatsapp2/state/local/conversa_state.dart';

enum Status { waiting, success, empty }

class ConversasPathController extends GetxController {
  RxList<ConversaPathData> conversas = <ConversaPathData>[].obs;
  Rx<Status> status = Status.waiting.obs;
  late StreamSubscription conversasStream;

  @override
  void onInit() {
    setPathListener();
    super.onInit();
  }

  @override
  onClose() {
    Print.red("---------- DISPOSING CONVERSAS PATH CONTROLLER ----------");
    conversasStream.cancel();
    conversas.clear();
    super.onClose();
  }

  setPathListener() async {
    Print.magenta("---------- INITIALIZING PATH CONVERSAS CONTROLLER LISTENER ----------");
    var myPhoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber ?? '';
    var conversasSnapshots = FirebaseFirestore.instance.collection('conversas').where('participantes', arrayContains: myPhoneNumber).snapshots();
    conversasStream = conversasSnapshots.listen(
      (event) async {
        Print.green("---------- CONVERSAS LISTENER FIRED ----------");

        List<ConversaPathData> newConversas = [];
        for (var newConversa in event.docs) {
          // *
          var pNewConversa = newConversa.data();

          // *
          Print.green("${pNewConversa['participantes']} contains $myPhoneNumber");
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
          Print.green("NEW CONVERSA ADDED: " + newConversaPathData.toString());
          newConversas.add(
            newConversaPathData,
          );
        }
        if (conversas.any((element) => element.conversaId == 'geral')) {
          newConversas.add(getConversaGeral());
        }
        conversas.value = newConversas;
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
      getConversaGeral(),
    );
  }

  ConversaPathData getConversaGeral() {
    return ConversaPathData(
      criadorNumber: '',
      conversaId: 'geral',
      titulo: 'Conversa Geral',
      descricao: ':)',
      criadorId: 'asd',
      thumbnail: '',
      isConversaPrivate: false,
      participantes: const [],
    );
  }

  void removeConversa(String conversaId, bool isConversaPrivate) async {
    Print.red("REMOVING CONVERSA: " + conversaId);
    Get.find<DesktopSelectedConversaController>().clearSelectedWidget();
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
    Get.delete<ConversaController>();
  }

  void removeConversaGeral() {
    Get.find<DesktopSelectedConversaController>().clearSelectedWidget();
    Print.red("REMOVING CONVERSA: GERAL");
    try {
      Get.delete<ConversaController>(tag: 'geral');
    } catch (e) {
      Print.red(e.toString());
    }

    for (var conversa in conversas) {
      if (conversa.conversaId == 'geral') {
        conversas.remove(conversa);
        return;
      }
    }
  }

  addNewConversa({
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

class ConversaPathData extends Equatable {
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
    dynamic thumbnail,
  }) {
    return ConversaPathData(
      conversaId: conversaId ?? this.conversaId,
      criadorId: criadorId ?? this.criadorId,
      criadorNumber: criadorNumber ?? this.criadorNumber,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      participantes: participantes ?? this.participantes,
      isConversaPrivate: personal ?? isConversaPrivate,
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
  List<Object?> get props => [
        conversaId,
        criadorId,
        criadorNumber,
        titulo,
        descricao,
        participantes,
        isConversaPrivate,
        thumbnail,
      ];
}
