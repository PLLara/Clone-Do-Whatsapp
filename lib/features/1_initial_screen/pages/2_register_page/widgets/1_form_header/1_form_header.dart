// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Coloque seu número de telefone",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2,
        ),
        const Text(
          "O Whatsapp 2 vai precisar verificar o teu numero de telefone :)",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}