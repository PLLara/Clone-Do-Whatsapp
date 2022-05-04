import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../../../common/state/user_state.dart';

enum Status { waiting, success, empty }

class PathConversasController extends GetxController {
  PathConversasController() {
    getPaths();
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

  getPaths() async {
    var myPhoneNumber = Get.find<UserController>().user.value?.phoneNumber ?? '';
    conversasStream = FirebaseFirestore.instance.collection('conversas').where('participantes', arrayContains: myPhoneNumber).snapshots().listen(
      (event) {
        List<ConversaPathData> newConversas = [];
        for (var newConversa in event.docs) {
          var pNewConversa = newConversa.data();
          if ((pNewConversa['participantes'] as List<dynamic>).contains(myPhoneNumber)) {
            print("${pNewConversa['participantes']} contains $myPhoneNumber");
            var newConversaPathData = ConversaPathData(
              conversaId: newConversa.id,
              titulo: pNewConversa['titulo'],
              descricao: pNewConversa['descricao'],
              criadorId: pNewConversa['criador'],
              thumbnail: pNewConversa['thumbnail'],
            );
            newConversas.add(
              newConversaPathData,
            );
          }
        }
        conversas.removeRange(0, conversas.length);
        conversas.addAll(newConversas);
        if (conversas.isEmpty) {
          conversas.add(
            ConversaPathData(
              conversaId: 'geral',
              titulo: 'Conversa Geral',
              descricao: ':)',
              criadorId: 'asd',
              thumbnail: '',
            ),
          );
        }
      },
    );
  }

  addNewPath({
    required String titulo,
    required List<String> participantes,
    String descricao = '',
    bool personal = false,
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
      'thumbnail': '',
      'participantes': participantes,
      'personal': personal,
    });
  }
}

class ConversaPathData {
  String conversaId;
  String titulo;
  String descricao;
  String criadorId;
  dynamic thumbnail;
  ConversaPathData({
    required this.conversaId,
    required this.titulo,
    required this.descricao,
    required this.criadorId,
    required this.thumbnail,
  });

  ConversaPathData copyWith({
    String? conversaId,
    String? titulo,
    String? descricao,
    String? criadorId,
    dynamic thumbnail,
  }) {
    return ConversaPathData(
      conversaId: conversaId ?? this.conversaId,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      criadorId: criadorId ?? this.criadorId,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'conversaId': conversaId,
      'titulo': titulo,
      'descricao': descricao,
      'criadorId': criadorId,
      'thumbnail': thumbnail,
    };
  }

  factory ConversaPathData.fromMap(Map map) {
    return ConversaPathData(
      conversaId: map['conversaId'] as String,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      criadorId: map['criadorId'] as String,
      thumbnail: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversaPathData.fromJson(String source) => ConversaPathData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Payload(conversaId: $conversaId, titulo: $titulo, descricao: $descricao, criadorId: $criadorId, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConversaPathData && other.conversaId == conversaId && other.titulo == titulo && other.descricao == descricao && other.criadorId == criadorId && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return conversaId.hashCode ^ titulo.hashCode ^ descricao.hashCode ^ criadorId.hashCode ^ thumbnail.hashCode;
  }
}
