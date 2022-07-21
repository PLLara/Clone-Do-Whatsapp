// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/model/message_model.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/widgets/1_corpo/1_corpo.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/widgets/2_peteco/2_peteco.dart';
import 'package:whatsapp2/state/global/contacts_state.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';
import 'package:whatsapp2/state/local/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/state/path_cubit.dart';

class ConversaTexts extends StatelessWidget {
  const ConversaTexts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: context.read<PathCubit>().state.conversaId,
    );
    mensageKey(int index) => conversaController.papo.value[index].usuario + conversaController.papo.value[index].message + conversaController.papo.value[index].date.toString();

    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            itemCount: conversaController.papo.length,
            itemBuilder: (e, index) {
              return MensagemWidget(
                mensagens: conversaController.papo.value,
                index: index,
                key: Key(
                  mensageKey(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MensagemWidget extends StatelessWidget {
  final List<MessageModel> mensagens;
  final int index;
  const MensagemWidget({
    required this.mensagens,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! Péssimo código, horrível, horrorosa, que não vai ser mais usado no futuro.
    var mensagem = mensagens[index];
    var mensagemAnterior = index < mensagens.length - 1 ? mensagens[index + 1] : mensagens[index];

    var isMine = mensagem.usuario == FirebaseAuth.instance.currentUser?.phoneNumber;
    var isDistinct = mensagem.usuario != mensagemAnterior.usuario;

    if (isMine) {
      return MessageScaffold(
        mensagem: mensagem,
        padding: const EdgeInsets.only(left: 60),
        alignment: MainAxisAlignment.end,
        color: const Color(0xff005C4B),
        showNumber: false,
        distinct: isDistinct,
      );
    }

    return MessageScaffold(
      mensagem: mensagem,
      padding: const EdgeInsets.only(right: 60),
      alignment: MainAxisAlignment.start,
      color: const Color(0xff202C33),
      distinct: isDistinct,
    );
  }
}

class MessageScaffold extends StatefulWidget {
  final EdgeInsets padding;
  final MainAxisAlignment alignment;
  final Color color;
  final bool showNumber;
  final bool distinct;
  final MessageModel mensagem;

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
                    alignment: alignment,
                    MARGIN: MARGIN,
                    color: color,
                    showNumber: showNumber,
                    nome: nome,
                    numero: numero,
                    myMensagem: myMensagem,
                    mensagem: mensagem,
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
