// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

class MensagemText extends StatelessWidget {
  const MensagemText({
    Key? key,
    required this.constraints,
    required this.mensagem,
  }) : super(key: key);

  final dynamic constraints;
  final String mensagem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
          padding: const EdgeInsets.only(top: 4.0),
          child: Wrap(
            children: [
              SelectableText(
                mensagem,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
