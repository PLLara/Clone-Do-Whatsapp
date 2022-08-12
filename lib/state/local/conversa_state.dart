// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/model/message_model.dart';

enum States { loading, ready, error }

class ConversaController extends GetxController {
  final String route;
  late final StreamSubscription<DatabaseEvent> streamMensagensAdicionadas;
  late final StreamSubscription<DatabaseEvent> streamMensagensRemovidas;
  final TextEditingController sendMessageController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    start();
    super.onInit();
  }

  @override
  void dispose() {
    Print.green("DISPOSING CONVERSACONTROLLER FOR ROUTE: " + route);
    streamMensagensAdicionadas.cancel();
    streamMensagensRemovidas.cancel();
    super.dispose();
  }

  @override
  onClose() {
    Print.green("CLOSING CONVERSACONTROLLER FOR ROUTE: " + route);
    streamMensagensAdicionadas.cancel();
    streamMensagensRemovidas.cancel();
    super.onClose();
  }

  cancelStream() async {
    await streamMensagensAdicionadas.cancel();
    await streamMensagensRemovidas.cancel();
  }

  final Rx<States> state = States.ready.obs;
  final RxList<MessageModel> papo = <MessageModel>[].obs;
  final RxBool iniciado = false.obs;
  final RxInt quantidadeDeMensagensNaoLidas = 0.obs;
  final RxBool emojiKeyboardClosed = false.obs;

  bool firstFalsePositive = true;

  ConversaController({required this.route});

  start() async {
    iniciado.value = false;
    state.value = States.loading;
    Print.magenta("------------------- INICIANDO A CONVERSA ${papo.length} --------------------------");
    // ! Definindo as variaveis
    final reference = FirebaseDatabase.instance.ref(route);
    var ref = await reference.once();
    var lista = <MessageModel>[];

    // ! Pegando os dados
    print("${papo.length}");

    for (final element in ref.snapshot.children.toList()) {
      MessageModel mensagemParseada = parseMessage(element);
      await recieveUrlData(mensagemParseada);
      lista.add(mensagemParseada);
      messageWasAdded(mensagemParseada);
    }

    papo.addAll(lista);
    sort();

    // ! Definindo listeners
    definirStreams();
    state.value = States.ready;
    focusNode.addListener(() {
      closeEmogiKeyboard();
    });
    update();
    Print.magenta("------------------- FINALIZANDO INICIALIZAÇÃO ${papo.length} --------------------------");
  }

  definirStreams() {
    final reference = FirebaseDatabase.instance.ref(route);
    definirStreamDeMensagensAdicionadas(reference);
    definirStreamDeMensagensRemovidas(reference);
  }

  void definirStreamDeMensagensRemovidas(DatabaseReference reference) {
    streamMensagensRemovidas = reference.onChildRemoved.listen(
      (event) {
        MessageModel? messageToBeRemoved;
        for (MessageModel legal in papo) {
          if (legal.id == parseMessage(event.snapshot).id) {
            print("----- MESSAGE REMOVED -----");
            messageToBeRemoved = legal;
          }
        }
        if (messageToBeRemoved != null) {
          papo.remove(messageToBeRemoved);
        }
      },
    );
  }

  void definirStreamDeMensagensAdicionadas(DatabaseReference reference) {
    streamMensagensAdicionadas = reference.orderByKey().limitToLast(1).onValue.listen(
      (event) async {
        try {
          if (firstFalsePositive) {
            firstFalsePositive = false; // ! isso aqui é culpa do firebase ;=;
            return;
          }
          MessageModel mensagemParseada = parseMessage(event.snapshot.children.last);

          await recieveUrlData(mensagemParseada);

          papo.insert(0, mensagemParseada);
          messageWasAdded(mensagemParseada);
          // sort();
          Print.green("----- MESSAGE ADDED -----");
        } catch (e) {
          Print.red("----- MESSAGE NOT ADDED -----");
        }
      },
    );
  }

  Future<void> recieveUrlData(MessageModel mensagemParseada) async {
    for (final url in findUrls(mensagemParseada.message)) {
      // !
      Metadata? metadata;

      // !
      if (cache[url] != null) {
        metadata = cache[url];
        print('found cached url');
      } else {
        metadata = await MetadataFetch.extract('https://zap2-reverse-proxy.herokuapp.com?q=' + url);
      }

      //*
      if (metadata == null || metadata.title == null) {
        // *
      } else {
        print(metadata.title);
        mensagemParseada.metaData = metadata;
        cache[url] = metadata;
      }
    }
  }

  messageWasAdded(MessageModel mensagem) {
    if (mensagem.usuario != FirebaseAuth.instance.currentUser?.phoneNumber) {
      quantidadeDeMensagensNaoLidas.value += 1;
      update();
    }
  }

  hasNewMessage() {
    if (quantidadeDeMensagensNaoLidas.value > 0) {
      quantidadeDeMensagensNaoLidas.value = 0;
      return true;
    }
    return false;
  }

  openEmogiKeyboard() {
    emojiKeyboardClosed.value = true;
    update();
  }

  closeEmogiKeyboard() {
    emojiKeyboardClosed.value = false;
    update();
  }

  sort() {
    papo.sort(
      (a, b) {
        var dateA = DateTime.parse(a.date.toString());
        var dateB = DateTime.parse(b.date.toString());
        return dateB.compareTo(dateA);
      },
    );
  }
}

MessageModel parseMessage(DataSnapshot element) {
  try {
    if (element.key != null) {
      var parsedValue = (element.value as Map);
      var time = DateTime.parse(parsedValue['date']);
      time = time.subtract(const Duration(hours: 3));
      return MessageModel(
        id: element.key ?? 'error',
        date: time,
        message: parsedValue['mensagem'] ?? 'ERROR',
        mediaLink: parsedValue['mediaLink'] ?? 'ERROR',
        usuario: parsedValue['usuario'] ?? 'ERROR',
        metaData: null,
      );
    } else {
      return MessageModel.error();
    }
  } catch (e) {
    print(e.toString());

    return MessageModel.error();
  }
}

List<String> findUrls(String text) {
  RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  Iterable<RegExpMatch> matches = exp.allMatches(text);

  List<String> urls = [];
  for (var match in matches) {
    urls.add(text.substring(match.start, match.end));
  }
  return urls;
}

Map<String, Metadata> cache = {};
