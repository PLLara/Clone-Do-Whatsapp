// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/desktop/width.dart';
import 'package:whatsapp2/common/widgets/scaffold_loading.dart';
import 'package:whatsapp2/features/2_app/web_layout.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';
import 'package:whatsapp2/state/global/contacts_state.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';
import 'package:whatsapp2/state/global/user_state.dart';
import '1_appbar/1_appbar_widget.dart';
import '2_app_content/2.2_camera/camera_widget.dart';
import '2_app_content/2.1_conversas/1_conversas/conversas_page.dart';

class TabSwitcherAndProvider extends StatelessWidget {
  const TabSwitcherAndProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! Colocando os State Controllers
    Get.put(
      ConversasPathController(),
    );
    Get.put(UserStateController());
    var contacts = Get.put(
      ContactsController(),
    );
    Get.put(
      DesktopSelectedConversaController(),
    );

    var windowSize = MediaQuery.of(context).size;
    return Obx(
      () {
        // ! Loading contatos
        if (contacts.contatos.isEmpty) {
          return const ScaffoldLoading(); // Garantindo que os contatos estejam carregados
        }
        // ! Versão desktop
        if (isDesktop(windowSize)) {
          return Whatsapp2WebLayout();
        }

        // ! Versão mobile
        return DefaultTabController(
          child: Scaffold(
            backgroundColor: Color(0xff121B22),
            appBar: MyAppBar(myTabs),
            body: TabBarView(
              physics: const ClampingScrollPhysics(),
              children: [
                for (var tab in myTabs) tab.myWidget
              ],
            ),
          ),
          length: myTabs.length,
        );
      },
    );
  }
}

class TabData {
  final Tab myTab;
  final Widget myWidget;
  TabData({
    required this.myTab,
    required this.myWidget,
  });
}

List<TabData> myTabs = [
  TabData(
    myTab: const Tab(
      text: 'CONVERSAS',
    ),
    myWidget: Conversas(),
  ),
  TabData(
    myTab: const Tab(
      text: 'STATUS',
    ),
    myWidget: Scaffold(
      body: Center(child: Text(":)")),
    ),
  ),
  TabData(
    myTab: const Tab(
      text: '📷︎',
    ),
    myWidget: Camera(),
  ),
];
