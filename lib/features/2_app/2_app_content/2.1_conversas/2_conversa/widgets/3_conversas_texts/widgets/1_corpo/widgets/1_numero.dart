// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/state/color_list.dart';

class MensagemUserNumeroMaybe extends StatelessWidget {
  const MensagemUserNumeroMaybe({
    Key? key,
    required this.nome,
    required this.numero,
    required this.showNumber,
  }) : super(key: key);

  final String nome;
  final String numero;
  final bool showNumber;

  @override
  Widget build(BuildContext context) {
    if (!showNumber) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                nome == '' ? numero : nome,
                style: TextStyle(
                  color: colors[int.parse(numero) % colors.length],
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
