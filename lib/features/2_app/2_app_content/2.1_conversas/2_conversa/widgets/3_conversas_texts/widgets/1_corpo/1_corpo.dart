// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/model/message_model.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/widgets/1_corpo/widgets/1_numero.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/widgets/1_corpo/widgets/2_foto.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/widgets/1_corpo/widgets/3_text.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/widgets/1_corpo/widgets/4_date.dart';

class MensagemCorpo extends StatelessWidget {
  const MensagemCorpo({
    Key? key,
    required this.alignment,
    required this.MARGIN,
    required this.color,
    required this.showNumber,
    required this.nome,
    required this.numero,
    required this.myMensagem,
    required this.mensagem,
    required this.dia,
    required this.constraints,
  }) : super(key: key);

  final MainAxisAlignment alignment;
  final double MARGIN;
  final Color color;
  final bool showNumber;
  final String nome;
  final String numero;
  final MessageModel myMensagem;
  final String mensagem;
  final String dia;
  final dynamic constraints;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: alignment,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: MARGIN,
              vertical: 1,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: IntrinsicWidth(
              // *
              child: Column(
                crossAxisAlignment: alignment == MainAxisAlignment.start ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  MensagemUserNumeroMaybe(
                    nome: nome,
                    numero: numero,
                    showNumber: showNumber,
                  ),
                  MensagemArquivoMaybe(
                    myMensagem: myMensagem,
                    showNumber: showNumber,
                  ),
                  MensagemText(
                    constraints: constraints,
                    textMessage: mensagem,
                  ),
                  MensagemDate(dia: dia),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
