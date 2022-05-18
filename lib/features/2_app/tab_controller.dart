// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/desktop/width.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';
import '1_appbar/1_appbar_widget.dart';
import '2_app_content/2.1_conversas/1_conversas/state/conversas_state.dart';
import '2_app_content/2.2_camera/camera_widget.dart';
import '2_app_content/2.1_conversas/1_conversas/conversas_page.dart';

class TabSwitcher extends StatefulWidget {
  const TabSwitcher({
    Key? key,
  }) : super(key: key);

  @override
  State<TabSwitcher> createState() => _TabSwitcherState();
}

class _TabSwitcherState extends State<TabSwitcher> {
  final desktopSelectedConversaController = Get.find<DesktopSelectedConversaController>();
  @override
  Widget build(BuildContext context) {
    Get.put(ConversasPathController(), permanent: true);

    var size = MediaQuery.of(context).size;
    if (isDesktop(size)) {
      return Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 34,
              child: Conversas(),
            ),
            Expanded(
              flex: 66,
              child: Obx(
                () {
                  if (desktopSelectedConversaController.conversaOpen.value) {
                    return desktopSelectedConversaController.selectedWidget.value;
                  } else {
                    return Placeholder();
                  }
                },
              ),
            ),
          ],
        ),
      );
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
