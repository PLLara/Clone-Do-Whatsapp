import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:whatsapp2/model/conversa.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';
import 'package:whatsapp2/state/local/conversa_state.dart';

enum Status { waiting, success, empty }

class ConversasPathController extends GetxController {
  RxList<ConversaPathData> conversas = <ConversaPathData>[].obs;
  Rx<Status> status = Status.waiting.obs;
  late StreamSubscription conversasStream;

  @override
  void onInit() {
    setPathListener();
    super.onInit();
  }

  @override
  onClose() {
    Print.red("---------- DISPOSING CONVERSAS PATH CONTROLLER ----------");
    conversasStream.cancel();
    conversas.clear();
    super.onClose();
  }

  setPathListener() async {
    // !
    Print.magenta("---------- INITIALIZING PATH CONVERSAS CONTROLLER LISTENER ----------");
    var myPhoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber ?? '';
    var conversasSnapshots = FirebaseFirestore.instance.collection('conversas').where('participantes', arrayContains: myPhoneNumber).snapshots();

    // *
    conversasStream = conversasSnapshots.listen(
      (event) async {
        Print.green("---------- CONVERSAS LISTENER FIRED ----------");

        List<ConversaPathData> newConversas = [];
        for (var newConversa in event.docs) {
          // *
          var newConversaData = newConversa.data();
          // Print.green("${newConversaData['participantes']} contains $myPhoneNumber");

          // *
          var newConversaPathData = ConversaPathData(
            criadorNumber: myPhoneNumber,
            conversaId: newConversa.id,
            titulo: newConversaData['titulo'],
            descricao: newConversaData['descricao'],
            criadorId: newConversaData['criador'],
            thumbnail: newConversaData['thumbnail'],
            isConversaPrivate: newConversaData['personal'],
            participantes: newConversaData['participantes'].cast<String>() as List<String>,
          );
          Print.green("NEW CONVERSA ADDED: $newConversaPathData");
          newConversas.add(
            newConversaPathData,
          );
        }

        // ! Determinando quais conversas foram removidas e deletando o seu estado
        RxList<ConversaPathData> oldConversas = conversas;

        List<String> oldConversasIds = oldConversas.map((conversa) => conversa.conversaId).toList();
        List<String> newConversasIds = newConversas.map((conversa) => conversa.conversaId).toList();
        List<String> removedConversasIds = oldConversasIds.where((id) => !newConversasIds.contains(id)).toList();

        List<ConversaPathData> removedConversas = oldConversas.where((conversa) => removedConversasIds.contains(conversa.conversaId)).toList();
        for (var conversa in removedConversas) {
          Print.red("REMOVING CONVERSA: ${conversa.conversaId}");
          Get.find<ConversaController>(tag: conversa.conversaId);
        }

        // ! Adicionando a conversa geral de volta
        if (conversas.any((element) => element.conversaId == 'geral')) {
          newConversas.add(getConversaGeral());
        }

        // ! Atualizando o estado
        conversas.value = newConversas;
        update();
      },
    );
  }

  void removeConversa(String conversaId, bool isConversaPrivate) async {
    Print.red("REMOVING CONVERSA: $conversaId");
    Get.find<DesktopSelectedConversaController>().clearSelectedWidget();
    var conversaController = Get.find<ConversaController>(tag: conversaId);
    try {
      conversaController.dispose();
    } catch (e) {
      Print.red("CONTROLLER ALREADY DISPOSED");
    }

    if (isConversaPrivate) {
      await FirebaseFirestore.instance.collection("conversas").doc(conversaId).delete();
    }

    for (var conversa in conversas) {
      if (conversa.conversaId == conversaId) {
        conversas.remove(conversa);
        return;
      }
    }
    Get.delete<ConversaController>();
  }

  addNewConversaToServer({
    required String titulo,
    required List<String> participantes,
    String descricao = '',
    bool personal = false,
    String? thumbnail,
  }) async {
    var creatorPhoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
    if (creatorPhoneNumber == null) {
      return;
    }
    participantes.add(creatorPhoneNumber);
    await FirebaseFirestore.instance.collection('conversas').add({
      'titulo': titulo,
      'descricao': descricao,
      'criador': FirebaseAuth.instance.currentUser?.uid,
      'thumbnail': thumbnail,
      'participantes': participantes,
      'personal': personal,
    });
  }

  void addConversaGeral() {
    for (var conversa in conversas) {
      if (conversa.conversaId == 'geral') {
        return;
      }
    }
    conversas.add(
      getConversaGeral(),
    );
  }

  ConversaPathData getConversaGeral() {
    return ConversaPathData(
      criadorNumber: '',
      conversaId: 'geral',
      titulo: 'Conversa Geral',
      descricao: ':)',
      criadorId: 'asd',
      thumbnail: '',
      isConversaPrivate: false,
      participantes: const [],
    );
  }

  void removeConversaGeral() {
    Get.find<DesktopSelectedConversaController>().clearSelectedWidget();
    Print.red("REMOVING CONVERSA: GERAL");
    try {
      Get.delete<ConversaController>(tag: 'geral');
    } catch (e) {
      Print.red(e.toString());
    }

    for (var conversa in conversas) {
      if (conversa.conversaId == 'geral') {
        conversas.remove(conversa);
        return;
      }
    }
  }
}
