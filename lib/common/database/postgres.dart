// ignore_for_file: avoid_print

import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

import 'model/conversa_model.dart';
import 'model/user_model.dart';

enum PgResponseStatus {
  success,
  failure,
}

class PostgresResponse<PayloadType> {
  final PgResponseStatus status;
  final String message;

  final PayloadType payload;

  const PostgresResponse(
    this.status,
    this.message, {
    required this.payload,
  });

  @override
  String toString() {
    return message;
  }
}

class Postgres {
  static final Postgres _singleton = Postgres._internal();
  factory Postgres() {
    return _singleton;
  }
  Postgres._internal();

  final PostgreSQLConnection connection = PostgreSQLConnection(
    "ec2-52-70-120-204.compute-1.amazonaws.com",
    5432,
    "d2t09buc90j96p",
    username: "yncpbtnklwlult",
    password: "1b983e0103400943db2b5e10367d572b3c5912103e136c5fbb3ff0f5f5bc1d89",
    useSSL: true,
  );

  Future<PostgresResponse<User?>> getUser(
    String fone,
  ) async {
    PostgreSQLResult result = await connection.query(
      "SELECT * FROM USERS WHERE FONE = @a",
      substitutionValues: {
        "a": fone
      },
    );

    if (result.isNotEmpty) {
      User user = User(id: result[0][0], nome: result[0][1], fone: result[0][2]);
      return PostgresResponse(
        PgResponseStatus.success,
        "Success: User ${result.asMap()} exists!",
        payload: user,
      );
    } else {
      return const PostgresResponse(
        PgResponseStatus.failure,
        'Failure: User does not exist!',
        payload: null,
      );
    }
  }

  Future<PostgresResponse<bool>> createUser(
    String nome,
    String fone,
  ) async {
    var userExistsQuery = await getUser(fone);
    var userDoesNotExists = (userExistsQuery).status == PgResponseStatus.failure;

    if (userDoesNotExists) {
      await connection.query(
        "INSERT INTO USERS VALUES (@a, @b, @c)",
        substitutionValues: {
          "a": const Uuid().v4(),
          "b": nome,
          "c": fone
        },
      );

      return const PostgresResponse(
        PgResponseStatus.success,
        "Success: User Created!",
        payload: true,
      );
    } else {
      return const PostgresResponse(
        PgResponseStatus.failure,
        'Failure: User Already Exists!',
        payload: false,
      );
    }
  }

  Future<PostgresResponse<Conversa?>> getConversa(String id) async {
    PostgreSQLResult conversaQuery = await connection.query(
      "select * from conversas where conversa_id = @conversaId",
      substitutionValues: {
        "conversaId": id
      },
    );
    if (conversaQuery.isEmpty) {
      return const PostgresResponse(
        PgResponseStatus.failure,
        'Failure: Conversa não encontrada',
        payload: null,
      );
    }

    var unparsedConversa = conversaQuery[0];
    Conversa conversa = Conversa(
      id: unparsedConversa[0],
      titulo: unparsedConversa[1],
      descricao: unparsedConversa[2],
      criadorId: unparsedConversa[3],
      thumbnail: unparsedConversa[4],
    );

    return PostgresResponse(
      PgResponseStatus.success,
      "Success: Conversa achada",
      payload: conversa,
    );
  }

  Future<PostgresResponse<List<Conversa>>> getAllConversasFromUserAdmin(
    String fone,
  ) async {
    var userQueryResult = await getUser(fone);
    if (userQueryResult.status == PgResponseStatus.failure) {
      return PostgresResponse(
        PgResponseStatus.failure,
        userQueryResult.message,
        payload: [],
      );
    }
    String userId = userQueryResult.payload!.id;

    PostgreSQLResult allConversasQuery = await connection.query(
      "select * from conversas where criador_id = @userId",
      substitutionValues: {
        "userId": userId
      },
    );

    List<Conversa> conversas = allConversasQuery.map((conversa) {
      return Conversa(
        id: conversa[0],
        titulo: conversa[1],
        descricao: conversa[2],
        criadorId: conversa[3],
        thumbnail: conversa[4],
      );
    }).toList();

    return PostgresResponse(
      PgResponseStatus.failure,
      userQueryResult.message,
      payload: conversas,
    );
  }

  Future<PostgresResponse> createConversa(
    String titulo,
    String descricao,
    String fone,
  ) async {
    var userQueryResult = await getUser(fone);
    if (userQueryResult.status == PgResponseStatus.failure) {
      return userQueryResult;
    }
    String criadorId = userQueryResult.payload!.id;

    print("Usuario existe, criando conversa...");
    var response = await connection.query(
      'INSERT INTO CONVERSAS VALUES (@uuid, @titulo, @descricao, @criadorId)',
      substitutionValues: {
        "uuid": const Uuid().v4(),
        "titulo": titulo,
        "descricao": descricao,
        "criadorId": criadorId,
      },
    );

    return PostgresResponse<PostgreSQLResult>(
      PgResponseStatus.success,
      'Success: ',
      payload: response,
    );
  }

  Future<PostgresResponse<dynamic>> adicionarUsuarioNaConversa(
    String conversaId,
    String fone,
  ) async {
    var userQueryResult = await getUser(fone);
    if (userQueryResult.status == PgResponseStatus.failure) {
      return userQueryResult;
    }

    await connection.query(
      'INSERT INTO participantes values (@id,@participanteId, @conversaId)',
      substitutionValues: {
        "id": const Uuid().v4(),
        "participanteId": userQueryResult.payload!.id,
        "conversaId": conversaId
      },
    );

    return const PostgresResponse<bool>(
      PgResponseStatus.success,
      'Deu certo, na teoria',
      payload: true,
    );
  }

  Future<PostgresResponse<List<Conversa>>> getAllConversasFromUserParticipante(String fone) async {
    var userQueryResult = await getUser(fone);
    if (userQueryResult.status == PgResponseStatus.failure) {
      return PostgresResponse(
        PgResponseStatus.failure,
        userQueryResult.message,
        payload: [],
      );
    }

    var allConversasQuery = await connection.query(
      "select * from conversas where conversa_id in(select conversa_id from participantes where participante_id = @userId)",
      substitutionValues: {
        "userId": userQueryResult.payload!.id
      },
    );

    List<Conversa> conversas = allConversasQuery.map((conversa) {
      return Conversa(
        id: conversa[0],
        titulo: conversa[1],
        descricao: conversa[2],
        criadorId: conversa[3],
        thumbnail: conversa[4],
      );
    }).toList();

    return PostgresResponse(
      PgResponseStatus.success,
      'Success: Deu certo',
      payload: conversas,
    );
  }
}

void main(List<String> args) async {
  var postgres = Postgres();
  await postgres.connection.open();
  print(await postgres.adicionarUsuarioNaConversa('8aa6c5ba-64e2-48cf-b1b7-4688f2d9fe51', '+5563992496492'));
  print((await postgres.getAllConversasFromUserParticipante('+5563992496492')).payload);

  postgres.connection.close();
}
