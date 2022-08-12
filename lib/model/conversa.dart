import 'dart:convert';
import 'package:equatable/equatable.dart';

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
