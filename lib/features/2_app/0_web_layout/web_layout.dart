import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/desktop/width.dart';
import 'package:whatsapp2/common/navigator/go_to_page.dart';
import 'package:whatsapp2/common/widgets/eu/user_photo.dart';
import 'package:whatsapp2/features/2_app/1_appbar/widgets/app_bar_dropdown.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/1_conversas/conversas_page.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/1_conversas/widgets/2_create_new_conversa_widget.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.3_contatos/contatos_page.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';

class WebZap2Interface extends StatelessWidget {
  const WebZap2Interface({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Whatsapp2WebLayoutBase(
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 34,
              child: Scaffold(
                appBar: AppBar(
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: UserPhotoWidget(),
                  ),
                  actions: [
                    isDesktop(MediaQuery.of(context).size)
                        ? IconButton(
                            onPressed: () {
                              goToPage(Contatos(), Get.to);
                            },
                            icon: const Icon(Icons.sms),
                          )
                        : const SizedBox(),
                    const AppBarDropDown(),
                  ],
                ),
                body: Conversas(),
                floatingActionButton: isDesktop(MediaQuery.of(context).size) ? null : const CreateNewConversaWidget(),
              ),
            ),
            const DesktopSelectedConversa(),
          ],
        ),
      ),
    );
  }
}

class Whatsapp2WebLayoutBase extends StatelessWidget {
  const Whatsapp2WebLayoutBase({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(MediaQuery.of(context).size)) {
      return Container(
        color: const Color(0xff0A1014),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            const ExpandedPadding(), // left
            Expanded(
              flex: 12,
              child: child,
            ),
            const ExpandedPadding(), // right
          ],
        ),
      );
    }
    return child;
  }
}

class DesktopSelectedConversa extends StatelessWidget {
  const DesktopSelectedConversa({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final desktopSelectedConversaController = Get.find<DesktopSelectedConversaController>();
    return Expanded(
      flex: 66,
      child: Obx(
        () {
          if (desktopSelectedConversaController.conversaOpen.value) {
            return desktopSelectedConversaController.selectedWidget.value;
          } else {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xff222E35),
                border: Border(
                  left: BorderSide(
                    color: Color(0x268696a0),
                    width: 1,
                  ),
                  bottom: BorderSide(color: Color(0xff008069), width: 6),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Clone do Zap",
                    style: Theme.of(context).textTheme.displayLarge,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ExpandedPadding extends StatelessWidget {
  const ExpandedPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: SizedBox(),
    );
  }
}
