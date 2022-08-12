import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/conversa_page.dart';
import 'package:whatsapp2/model/conversa.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';

class DesktopSelectedConversaController extends GetxController {
  Rx<Conversa> selectedWidget = conversaNula.obs;
  Rx<bool> conversaOpen = false.obs;

  // Update selectedWidget
  void updateSelectedWidget(Conversa widget) {
    conversaOpen.value = true;
    selectedWidget.value = widget;
    update();
  }

  clearSelectedWidget() {
    conversaOpen.value = false;
    selectedWidget.value = conversaNula;
    update();
  }
}

var conversaNula = Conversa(
  path: ConversaPathData(
    conversaId: 'placeholder',
    criadorId: 'placeholder',
    criadorNumber: 'placeholder',
    descricao: 'placeholder',
    isConversaPrivate: false,
    participantes: const [],
    thumbnail: null,
    titulo: '',
  ),
  injectedConversaPhoto: const Placeholder(),
  injectedTitle: const Placeholder(),
);
