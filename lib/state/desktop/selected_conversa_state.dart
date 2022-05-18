import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/1_conversas/state/conversas_state.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/conversa_page.dart';

class DesktopSelectedConversaController extends GetxController {
  Rx<Conversa> selectedWidget = Conversa(
    path: ConversaPathData(conversaId: 'placeholder', criadorId: 'placeholder', criadorNumber: 'placeholder', descricao: 'placeholder', isConversaPrivate: false, participantes: [], thumbnail: null, titulo: ''),
    injectedConversaPhoto: const Placeholder(),
    injectedTitle: const Placeholder(),
  ).obs;
  Rx<bool> conversaOpen = false.obs;

  // Update selectedWidget
  void updateSelectedWidget(Conversa widget) {
    conversaOpen.value = true;
    selectedWidget.value = widget;
    update();
  }
}
