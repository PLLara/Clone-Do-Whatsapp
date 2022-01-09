import 'dart:convert';

class Pessoa {
  String nome;
  int idade;
  bool doenca;
  String cpf;
  Pessoa({
    required this.nome,
    required this.idade,
    required this.doenca,
    required this.cpf,
  });

  Pessoa copyWith({
    String? nome,
    int? idade,
    bool? doenca,
    String? cpf,
  }) {
    return Pessoa(
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      doenca: doenca ?? this.doenca,
      cpf: cpf ?? this.cpf,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'idade': idade,
      'doenca': doenca,
      'cpf': cpf,
    };
  }

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return Pessoa(
      nome: map['nome'] ?? '',
      idade: map['idade']?.toInt() ?? 0,
      doenca: map['doenca'] ?? false,
      cpf: map['cpf'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Pessoa.fromJson(String source) => Pessoa.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Pessoa(nome: $nome, idade: $idade, doenca: $doenca, cpf: $cpf)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pessoa && other.nome == nome && other.idade == idade && other.doenca == doenca && other.cpf == cpf;
  }

  @override
  int get hashCode {
    return nome.hashCode ^ idade.hashCode ^ doenca.hashCode ^ cpf.hashCode;
  }
}
