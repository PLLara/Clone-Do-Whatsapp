import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum Status { waiting, success, empty }

class PathConversasController extends GetxController {
  PathConversasController() {
    getPaths();
  }

  addNewPath({required String titulo, String descricao = 'sem descricao'}) async {
    
    var response = await http.post(
      Uri.parse('https://whatsapp-2-backend.herokuapp.com/createconversa'),
      body: {
        "titulo": titulo,
        "descricao": descricao,
        "criadorFone": FirebaseAuth.instance.currentUser?.phoneNumber ?? ''
      },
    );

    print(response.body);
  }

  getPaths() async {
    conversas.removeRange(0, conversas.length);
    var response = await http.post(
      Uri.parse('https://whatsapp-2-backend.herokuapp.com/getconversafromuser'),
      body: {
        "fone": FirebaseAuth.instance.currentUser?.phoneNumber ?? '',
      },
    );
    List<ConversaPathData> newPaths = [];

    var parsedBody = (json.decode(response.body));

    if (parsedBody['status'] == 'success') {
      for (var element in (parsedBody['payload'] as Iterable)) {
        newPaths.add(ConversaPathData.fromMap(element));
      }
    }

    conversas.addAll(newPaths);
  }

  RxList<ConversaPathData> conversas = <ConversaPathData>[].obs;
  Rx<Status> status = Status.waiting.obs;
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
