// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/desktop/width.dart';
import 'package:whatsapp2/common/widgets/eu/user_photo.dart';
import 'package:whatsapp2/common/widgets/scaffold_loading.dart';
import 'package:whatsapp2/features/2_app/1_appbar/widgets/app_bar_dropdown.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';
import 'package:whatsapp2/state/global/contacts_state.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';
import 'package:whatsapp2/state/global/user_state.dart';
import '1_appbar/1_appbar_widget.dart';
import '2_app_content/2.2_camera/camera_widget.dart';
import '2_app_content/2.1_conversas/1_conversas/conversas_page.dart';

class TabSwitcherAndProvider extends StatefulWidget {
  const TabSwitcherAndProvider({
    Key? key,
  }) : super(key: key);

  @override
  State<TabSwitcherAndProvider> createState() => _TabSwitcherAndProviderState();
}

class _TabSwitcherAndProviderState extends State<TabSwitcherAndProvider> {
  @override
  Widget build(BuildContext context) {
    // ! State Controllers
    var conversas = Get.put(
      ConversasPathController(),
    );
    var contacts = Get.put(
      ContactsController(),
    );
    var user = Get.put(UserStateController());

    var size = MediaQuery.of(context).size;
    if (isDesktop(size)) {
      return Obx(() {
        if (contacts.contatos.isEmpty) {
          return const ScaffoldLoading();
        }
        return Whatsapp2WebLayout();
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
    return Obx(() {
      if (contacts.contatos.isEmpty) {
        return const ScaffoldLoading();
      }
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
    });
  }
}

class Whatsapp2WebLayout extends StatelessWidget {
  const Whatsapp2WebLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff0A1014),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 10,
            child: Scaffold(
              body: Row(
                children: [
                  Expanded(
                    flex: 34,
                    child: Scaffold(
                      appBar: AppBar(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserPhotoWidget(),
                        ),
                        actions: const [
                          AppBarDropDown(),
                        ],
                      ),
                      body: Conversas(),
                    ),
                  ),
                  DesktopSelectedConversa(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class DesktopSelectedConversa extends StatelessWidget {
  const DesktopSelectedConversa({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desktopSelectedConversaController = Get.put(
      DesktopSelectedConversaController(),
    );
    return Expanded(
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
