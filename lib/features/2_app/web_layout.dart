import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/desktop/width.dart';
import 'package:whatsapp2/common/widgets/eu/user_photo.dart';
import 'package:whatsapp2/features/2_app/1_appbar/widgets/app_bar_dropdown.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/1_conversas/conversas_page.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';

class Whatsapp2WebLayoutBase extends StatelessWidget {
  const Whatsapp2WebLayoutBase({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb && isDesktop(MediaQuery.of(context).size)) {
      return Container(
        color: const Color(0xff0A1014),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            const ExpandedPadding(), // left
            Expanded(
              child: child,
              flex: 12,
            ),
            const ExpandedPadding(), // right
          ],
        ),
      );
    }
    return child;
  }
}

class WebZap2Interface extends StatelessWidget {
  const WebZap2Interface({
    Key? key,
  }) : super(key: key);

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
                  actions: const [
                    AppBarDropDown(),
                  ],
                ),
                body: const Conversas(),
              ),
            ),
            const DesktopSelectedConversa(),
          ],
        ),
      ),
    );
  }
}

class ExpandedPadding extends StatelessWidget {
  const ExpandedPadding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: SizedBox(),
    );
  }
}

class DesktopSelectedConversa extends StatelessWidget {
  const DesktopSelectedConversa({
    Key? key,
  }) : super(key: key);

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
