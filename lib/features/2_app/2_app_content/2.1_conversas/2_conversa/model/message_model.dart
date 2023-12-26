import 'dart:convert';

import 'package:metadata_fetch/metadata_fetch.dart';

class MessageModel {
  final String id;
  final DateTime date;
  final String message;
  final String mediaLink;
  final String usuario;
  Metadata? metaData;

  MessageModel({
    required this.id,
    required this.date,
    required this.message,
    required this.mediaLink,
    required this.usuario,
    required this.metaData,
  });

  MessageModel copyWith({
    String? id,
    DateTime? date,
    String? message,
    String? mediaLink,
    String? usuario,
    Metadata? metaData,
  }) {
    return MessageModel(
      id: id ?? this.id,
      date: date ?? this.date,
      message: message ?? this.message,
      mediaLink: mediaLink ?? this.mediaLink,
      usuario: usuario ?? this.usuario,
      metaData: metaData ?? this.metaData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(),
      'message': message,
      'mediaLink': mediaLink,
      'usuario': usuario,
      'metaData': metaData,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      date: DateTime.parse(map['date']).toLocal(),
      message: map['message'],
      mediaLink: map['mediaLink'],
      usuario: map['usuario'],
      metaData: null,
    );
  }

  factory MessageModel.error() {
    return MessageModel(
      id: 'ERROR-ERROR-ERROR',
      date: DateTime.now(),
      message: 'ERROR-ERROR-ERROR',
      mediaLink: 'ERROR-ERROR-ERROR',
      usuario: 'ERROR-ERROR-ERROR',
      metaData: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, date: $date, message: $message, mediaLink: $mediaLink, usuario: $usuario, metaData: $metaData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel && other.id == id && other.date == date && other.message == message && other.mediaLink == mediaLink && other.usuario == usuario && other.metaData == metaData;
  }

  @override
  int get hashCode {
    return id.hashCode ^ date.hashCode ^ message.hashCode ^ mediaLink.hashCode ^ usuario.hashCode ^ metaData.hashCode;
  }
}
