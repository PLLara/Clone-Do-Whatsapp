import 'dart:convert';

class Conversa {
  String id;
  String titulo;
  String descricao;
  String criadorId;
  dynamic thumbnail;
  Conversa({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.criadorId,
    required this.thumbnail,
  });

  Conversa copyWith({
    String? id,
    String? titulo,
    String? descricao,
    String? criadorId,
    dynamic thumbnail,
  }) {
    return Conversa(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      criadorId: criadorId ?? this.criadorId,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'criadorId': criadorId,
      'thumbnail': thumbnail,
    };
  }

  factory Conversa.fromMap(Map<String, dynamic> map) {
    return Conversa(
      id: map['id'] ?? '',
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      criadorId: map['criadorId'] ?? '',
      thumbnail: map['thumbnail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversa.fromJson(String source) => Conversa.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Conversa(id: $id, titulo: $titulo, descricao: $descricao, criadorId: $criadorId, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Conversa &&
      other.id == id &&
      other.titulo == titulo &&
      other.descricao == descricao &&
      other.criadorId == criadorId &&
      other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      titulo.hashCode ^
      descricao.hashCode ^
      criadorId.hashCode ^
      thumbnail.hashCode;
  }
}
