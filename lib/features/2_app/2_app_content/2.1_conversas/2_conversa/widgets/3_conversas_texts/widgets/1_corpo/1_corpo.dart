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
    required this.text,
    required this.dia,
    required this.constraints,
    required this.mensagem,
  }) : super(key: key);

  final MainAxisAlignment alignment;
  final double MARGIN;
  final Color color;
  final bool showNumber;
  final String nome;
  final String numero;
  final MessageModel myMensagem;
  final String text;
  final String dia;
  final dynamic constraints;

  final MessageModel mensagem;

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
                  mensagem.metaData != null
                      ? TextButton(
                          onPressed: () {
                            print('metaData');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            color: Colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    'https://zap2-reverse-proxy.herokuapp.com?q=${mensagem.metaData?.image ?? ''}',
                                    errorBuilder: (e, a, c) => Container(),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Wrap(children: [
                                    Text(mensagem.metaData?.title ?? ''),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
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
                    textMessage: text,
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
