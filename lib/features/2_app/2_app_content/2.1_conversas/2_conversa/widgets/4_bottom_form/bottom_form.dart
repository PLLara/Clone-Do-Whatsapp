import 'package:flutter/material.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/4_bottom_form/widgets/1_text_image_form.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/4_bottom_form/widgets/2_submit.dart';

class BottomForm extends StatelessWidget {
  const BottomForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          TextAndImageForm(),
          Submit(),
        ],
      ),
    );
  }
}
