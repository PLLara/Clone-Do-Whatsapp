import 'dart:convert';

class User {
  String id;
  String nome;
  String fone;
  User({
    required this.id,
    required this.nome,
    required this.fone,
  });

  User copyWith({
    String? id,
    String? nome,
    String? fone,
  }) {
    return User(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      fone: fone ?? this.fone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'fone': fone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      fone: map['fone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, nome: $nome, fone: $fone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.nome == nome &&
      other.fone == fone;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ fone.hashCode;
}
