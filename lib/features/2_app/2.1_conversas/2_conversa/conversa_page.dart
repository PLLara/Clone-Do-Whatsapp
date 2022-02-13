// ignore_for_file: avoid_print, non_constant_identifier_names, invalid_use_of_protected_member
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:whatsapp2/common/state/contacts_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/model/message_model.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/color_list.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/path_cubit.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/widgets/AppBar.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/widgets/bottom_input.dart';

class Conversa extends StatefulWidget {
  final String tag;

  const Conversa({Key? key, required this.tag}) : super(key: key);

  @override
  State<Conversa> createState() => _ConversaState();
}

class _ConversaState extends State<Conversa> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PathCubit(widget.tag),
      child: Scaffold(
        backgroundColor: const Color(0xff0B141A),
        appBar: ConversaAppBarBind(),
        body: const ConversaBody(),
      ),
    );
  }
}

class ConversaBody extends StatelessWidget {
  const ConversaBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Image(
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/fullBackground.jpg'),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: const [
            ConversaTexts(),
            BottomInputBar()
          ],
        ),
      ],
    );
  }
}

class ConversaTexts extends StatelessWidget {
  const ConversaTexts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(tag: context.read<PathCubit>().state);
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
    var mensagem = mensagens[index];
    var aMensagemEMinha = mensagem.usuario == FirebaseAuth.instance.currentUser?.phoneNumber;

    var mensagemAnterior = index < mensagens.length - 1 ? mensagens[index + 1] : mensagens[index];
    var aMensagemEDistinta = mensagem.usuario != mensagemAnterior.usuario;

    if (aMensagemEMinha) {
      return MessageScaffold(
        mensagem: mensagem,
        padding: const EdgeInsets.only(left: 60),
        alignment: MainAxisAlignment.end,
        color: const Color(0xff005C4B),
        showNumber: false,
        distinct: aMensagemEDistinta,
      );
    }

    return MessageScaffold(
      mensagem: mensagem,
      padding: const EdgeInsets.only(right: 60),
      color: const Color(0xff202C33),
      alignment: MainAxisAlignment.start,
      distinct: aMensagemEDistinta,
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
    String data = (widget.mensagem.date.toString()).split(' ')[1].substring(0, 5);
    String userNumber = widget.mensagem.usuario;
    String userName = '';
    String textoMensagem = widget.mensagem.message;

    contactsController.contatos.forEach((element) {
      if (element.phones.isEmpty) {
        return;
      }
      if (element.phones[0].normalizedNumber.length < 8) {
        return;
      }
      var someNumber = element.phones[0].normalizedNumber.substring(element.phones[0].normalizedNumber.length - 8);

      if (someNumber == userNumber.substring(userNumber.length - 8)) {
        userName = element.displayName;
      }
    });

    const double size = 10;
    const double margin = 12;

    return Padding(
      padding: widget.padding,
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: widget.alignment,
            children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: margin,
                    vertical: 1,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: widget.alignment == MainAxisAlignment.start ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        widget.showNumber
                            ? Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        userName == '' ? userNumber : userName,
                                        style: TextStyle(color: colors[int.parse(userNumber) % colors.length], fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        widget.mensagem.mediaLink != ''
                            ? TextButton(
                                onPressed: () {
                                  Get.to(
                                    () => Scaffold(
                                      body: Center(
                                        child: Hero(
                                          tag: widget.mensagem.mediaLink,
                                          child: CachedNetworkImage(
                                            imageUrl: widget.mensagem.mediaLink,
                                            placeholder: (context, url) => const Loading(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: widget.mensagem.mediaLink,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.mensagem.mediaLink,
                                    placeholder: (context, url) => const Loading(),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SelectableText(textoMensagem),
                        Text(
                          data,
                          style: const TextStyle(color: Color(0xaaffffff), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          widget.showNumber
              ? Positioned(
                  left: margin / 4,
                  top: 1,
                  child: widget.distinct
                      ? Container(
                          width: size * 3,
                          height: size,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: widget.color,
                          ),
                        )
                      : const SizedBox(),
                )
              : Positioned(
                  right: margin / 4,
                  top: 1,
                  child: widget.distinct
                      ? Container(
                          width: size * 3,
                          height: size,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: widget.color,
                          ),
                        )
                      : const SizedBox(),
                )
        ],
      ),
    );
  }
}
