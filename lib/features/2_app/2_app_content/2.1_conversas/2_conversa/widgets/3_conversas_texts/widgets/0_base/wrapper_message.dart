// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/model/message_model.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/widgets/1_corpo/1_corpo.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/widgets/2_peteco/2_peteco.dart';
import 'package:whatsapp2/state/global/contacts_state.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/state/path_cubit.dart';

const MY_MESSAGE_COLOR = Color(0xff005C4B);
const NOT_MY_MESSAGE_COLOR = Color(0xff202C33);

class WrapperMyMessageScaffold extends StatefulWidget {
  const WrapperMyMessageScaffold({
    Key? key,
    required this.mensagem,
    required this.distinct,
  }) : super(key: key);

  final MessageModel mensagem;
  final bool distinct;

  @override
  State<WrapperMyMessageScaffold> createState() => _WrapperMyMessageScaffoldState();
}

class _WrapperMyMessageScaffoldState extends State<WrapperMyMessageScaffold> {
  @override
  Widget build(BuildContext context) {
    MessageModel mensagem = widget.mensagem;
    bool distinct = widget.distinct;

    return MessageScaffold(
      mensagem: mensagem,
      padding: const EdgeInsets.only(left: 60),
      alignment: MainAxisAlignment.end,
      color: MY_MESSAGE_COLOR,
      showNumber: false,
      distinct: distinct,
    );
  }
}

class WrapperNotMyMessageScaffold extends StatefulWidget {
  const WrapperNotMyMessageScaffold({
    Key? key,
    required this.mensagem,
    required this.distinct,
  }) : super(key: key);

  final MessageModel mensagem;
  final bool distinct;

  @override
  State<WrapperNotMyMessageScaffold> createState() => _WrapperNotMyMessageScaffoldState();
}

class _WrapperNotMyMessageScaffoldState extends State<WrapperNotMyMessageScaffold> {
  @override
  Widget build(BuildContext context) {
    MessageModel mensagem = widget.mensagem;
    bool distinct = widget.distinct;

    return MessageScaffold(
      mensagem: mensagem,
      padding: const EdgeInsets.only(right: 60),
      alignment: MainAxisAlignment.start,
      color: NOT_MY_MESSAGE_COLOR,
      distinct: distinct,
    );
  }
}

class MessageScaffold extends StatefulWidget {
  final MessageModel mensagem;
  final bool distinct;

  final bool showNumber;
  final Color color;
  final EdgeInsets padding;
  final MainAxisAlignment alignment;

  const MessageScaffold({
    // ! TODO: PROP DRILLING
    Key? key,
    required this.mensagem,
    required this.padding,
    required this.alignment,
    required this.color,
    this.showNumber = true,
    this.distinct = false,
  }) : super(key: key);

  @override
  State<MessageScaffold> createState() => _MessageScaffoldState();
}

class _MessageScaffoldState extends State<MessageScaffold> {
  ContactsController contactsController = Get.find();

  @override
  Widget build(BuildContext context) {
    // ! TODO: Refazer o código.
    String dia = (widget.mensagem.date.toString()).split(' ')[1].substring(0, 5);
    String numero = widget.mensagem.usuario;
    String nome = '';
    String mensagem = widget.mensagem.message;

    for (var contato in contactsController.contatos) {
      if (contato.phones.isEmpty) {
        continue;
      }
      if (contato.phones[0].normalizedNumber.length < 8) {
        continue;
      }
      var someNumber = contato.phones[0].normalizedNumber.substring(contato.phones[0].normalizedNumber.length - 8);
      if (someNumber == numero.substring(numero.length - 8)) {
        nome = contato.displayName;
      }
    }

    // ! AUX CONSTANTS
    const double SIZE = 10;
    const double MARGIN = 12;
    return BlocBuilder<PathCubit, ConversaPathData>(
      builder: (context, state) {
        var padding = widget.padding;
        var alignment = widget.alignment;

        return Padding(
          padding: padding,
          child: LayoutBuilder(
            builder: (a, constraints) {
              var color = widget.color;
              var showNumber = widget.showNumber;
              var myMensagem = widget.mensagem;
              var distinct = widget.distinct;

              return Stack(
                children: [
                  MensagemCorpo(
                    mensagem: widget.mensagem,
                    alignment: alignment,
                    MARGIN: MARGIN,
                    color: color,
                    showNumber: showNumber,
                    nome: nome,
                    numero: numero,
                    myMensagem: myMensagem,
                    text: mensagem,
                    dia: dia,
                    constraints: constraints,
                  ),
                  MensagemPeteco(
                    showNumber,
                    MARGIN,
                    distinct,
                    SIZE,
                    color,
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
