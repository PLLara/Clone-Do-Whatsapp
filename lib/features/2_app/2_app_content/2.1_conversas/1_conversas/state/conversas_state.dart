import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../../common/state/user_state.dart';

enum Status { waiting, success, empty }

class PathConversasController extends GetxController {
  PathConversasController() {
    setPathListener();
  }

  RxList<ConversaPathData> conversas = <ConversaPathData>[].obs;
  Rx<Status> status = Status.waiting.obs;
  late StreamSubscription conversasStream;

  @override
  void dispose() {
    conversasStream.cancel();
    conversas.removeRange(0, conversas.length);
    super.dispose();
  }

  setPathListener() async {
    var myPhoneNumber = Get.find<UserController>().user.value?.phoneNumber ?? '';
    print("participantes must contain " + myPhoneNumber);
    var conversasSnapshots = FirebaseFirestore.instance.collection('conversas').where('participantes', arrayContains: myPhoneNumber).snapshots();
    conversasStream = conversasSnapshots.listen(
      (event) {
        List<ConversaPathData> newConversas = [];
        for (var newConversa in event.docs) {
          var pNewConversa = newConversa.data();
          if ((pNewConversa['participantes'] as List<dynamic>).contains(myPhoneNumber)) {
            print("${pNewConversa['participantes']} contains $myPhoneNumber");
            var newConversaPathData = ConversaPathData(
              criadorNumber: myPhoneNumber,
              conversaId: newConversa.id,
              titulo: pNewConversa['titulo'],
              descricao: pNewConversa['descricao'],
              criadorId: pNewConversa['criador'],
              thumbnail: pNewConversa['thumbnail'],
              personal: pNewConversa['personal'],
              participantes: pNewConversa['participantes'].cast<String>() as List<String>,
            );
            newConversas.add(
              newConversaPathData,
            );
          }
        }
        conversas.removeRange(0, conversas.length);
        conversas.addAll(newConversas);
        if (conversas.isEmpty) {
          addConversaGeral();
        }
      },
    );
  }

  void addConversaGeral() {
    conversas.add(
      ConversaPathData(
        criadorNumber: '',
        conversaId: 'geral',
        titulo: 'Conversa Geral',
        descricao: ':)',
        criadorId: 'asd',
        thumbnail: '',
        personal: false,
        participantes: [],
      ),
    );
  }

  addNewPath({
    required String titulo,
    required List<String> participantes,
    String descricao = '',
    bool personal = false,
    String? thumbnail,
  }) async {
    var creatorPhoneNumber = Get.find<UserController>().user.value?.phoneNumber;
    if (creatorPhoneNumber == null) {
      return;
    }
    participantes.add(creatorPhoneNumber);
    await FirebaseFirestore.instance.collection('conversas').add({
      'titulo': titulo,
      'descricao': descricao,
      'criador': Get.find<UserController>().user.value?.uid,
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
  bool personal;
  dynamic thumbnail;
  ConversaPathData({
    required this.conversaId,
    required this.criadorId,
    required this.criadorNumber,
    required this.titulo,
    required this.descricao,
    required this.participantes,
    required this.personal,
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
      personal: personal ?? this.personal,
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
      'personal': personal,
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
      personal: map['personal'],
      thumbnail: map['thumbnail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversaPathData.fromJson(String source) => ConversaPathData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConversaPathData(conversaId: $conversaId, criadorId: $criadorId, criadorNumber: $criadorNumber, titulo: $titulo, descricao: $descricao, participantes: $participantes, personal: $personal, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConversaPathData && other.conversaId == conversaId && other.criadorId == criadorId && other.criadorNumber == criadorNumber && other.titulo == titulo && other.descricao == descricao && listEquals(other.participantes, participantes) && other.personal == personal && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return conversaId.hashCode ^ criadorId.hashCode ^ criadorNumber.hashCode ^ titulo.hashCode ^ descricao.hashCode ^ participantes.hashCode ^ personal.hashCode ^ thumbnail.hashCode;
  }
}
