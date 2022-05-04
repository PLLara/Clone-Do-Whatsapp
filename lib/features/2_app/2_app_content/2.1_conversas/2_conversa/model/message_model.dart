import 'dart:convert';

class MessageModel {
  final String id;
  final DateTime date;
  final String message;
  final String mediaLink;
  final String usuario;

  MessageModel({
    required this.id,
    required this.date,
    required this.message,
    required this.mediaLink,
    required this.usuario,
  });

  MessageModel copyWith({
    String? id,
    DateTime? date,
    String? message,
    String? mediaLink,
    String? usuario,
  }) {
    return MessageModel(
      id: id ?? this.id,
      date: date ?? this.date,
      message: message ?? this.message,
      mediaLink: mediaLink ?? this.mediaLink,
      usuario: usuario ?? this.usuario,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'message': message,
      'mediaLink': mediaLink,
      'usuario': usuario,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      message: map['message'] ?? '',
      mediaLink: map['mediaLink'] ?? '',
      usuario: map['usuario'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, date: $date, message: $message, mediaLink: $mediaLink, usuario: $usuario)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel && other.id == id && other.date == date && other.message == message && other.mediaLink == mediaLink && other.usuario == usuario;
  }

  @override
  int get hashCode {
    return id.hashCode ^ date.hashCode ^ message.hashCode ^ mediaLink.hashCode ^ usuario.hashCode;
  }
}
