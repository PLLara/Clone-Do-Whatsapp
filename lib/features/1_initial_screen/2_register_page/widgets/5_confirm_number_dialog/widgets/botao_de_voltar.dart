
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BotaoDeVoltar extends StatelessWidget {
  const BotaoDeVoltar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.back();
      },
      child: const Text("Não, Voltar"),
    );
  }
}
