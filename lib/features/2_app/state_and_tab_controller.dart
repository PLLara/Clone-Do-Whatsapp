// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/desktop/width.dart';
import 'package:whatsapp2/features/2_app/0_web_layout/web_layout.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';
import 'package:whatsapp2/state/global/contacts_state.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';
import 'package:whatsapp2/state/global/user_state.dart';

import '1_appbar/1_appbar_widget.dart';
import '2_app_content/2.1_conversas/1_conversas/conversas_page.dart';

class TabSwitcherAndProvider extends StatelessWidget {
  const TabSwitcherAndProvider({super.key});

  @override
  Widget build(BuildContext context) {
    // ! Colocando os State Controllers
    Get.put(ConversasPathController());
    Get.put(UserStateController());
    Get.put(ContactsController());
    Get.put(DesktopSelectedConversaController());

    // ! Versão Desktop
    if (kIsWeb && isDesktop(MediaQuery.of(context).size)) {
      return const WebZap2Interface();
    }
    // ! Versão mobile
    return DefaultTabController(
      length: myTabs.length,
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
  // TabData(
  //   myTab: const Tab(
  //     text: '📷︎',
  //   ),
  //   myWidget: Camera(),
  // ),
];
