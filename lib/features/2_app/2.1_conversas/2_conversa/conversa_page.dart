// ignore_for_file: avoid_print, non_constant_identifier_names, invalid_use_of_protected_member
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/1_conversas/state/contacts_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/color_list.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/widgets/AppBar.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/widgets/bottom_input.dart';

class ConversaGeral extends StatefulWidget {
  const ConversaGeral({
    Key? key,
  }) : super(key: key);

  @override
  State<ConversaGeral> createState() => _ConversaGeralState();
}

class _ConversaGeralState extends State<ConversaGeral> {
  final ConversaController conversaController = Get.find<ConversaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConversaAppBarBind(),
      body: const ConversaBody(),
    );
  }
}

class ConversaBody extends StatelessWidget {
  const ConversaBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ConversaTexts(),
        BottomInputBar()
      ],
    );
  }
}

class ConversaTexts extends StatelessWidget {
  ConversaTexts({
    Key? key,
  }) : super(key: key);

  final ConversaController conversaController = Get.find<ConversaController>();
  mensageKey(int index) => conversaController.papo.value[index]['usuario'] + conversaController.papo.value[index]['mensagem'] + conversaController.papo.value[index]['date'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemCount: conversaController.papo.length,
          itemBuilder: (e, index) {
            return MensagemWidget(
              mensagens: conversaController.papo.value,
              index: index,
              key: Key(mensageKey(index)),
            );
          },
        ),
      ),
    );
  }
}

class MensagemWidget extends StatelessWidget {
  final List<dynamic> mensagens;

  final int index;

  MensagemWidget({
    required this.mensagens,
    required this.index,
    Key? key,
  }) : super(key: key);
  final ConversaController conversaController = Get.find<ConversaController>();

  @override
  Widget build(BuildContext context) {
    var mensagem = mensagens[index];
    var aMensagemEMinha = mensagem['usuario'] == FirebaseAuth.instance.currentUser?.phoneNumber;

    var mensagemAnterior = index < mensagens.length - 1 ? mensagens[index + 1] : mensagens[index];
    var aMensagemEDistinta = mensagem['usuario'] != mensagemAnterior['usuario'];

    if (aMensagemEMinha) {
      return MessageScaffold(
        mensagem: mensagem,
        padding: const EdgeInsets.only(left: 60),
        alignment: MainAxisAlignment.end,
        color: Colors.amber,
        showNumber: false,
        distinct: aMensagemEDistinta,
      );
    }

    return MessageScaffold(
      mensagem: mensagem,
      padding: const EdgeInsets.only(right: 60),
      alignment: MainAxisAlignment.start,
      color: const Color(
        0xff202C33,
      ),
      distinct: aMensagemEDistinta,
    );
  }
}

class MessageScaffold extends StatelessWidget {
  final EdgeInsets padding;
  final MainAxisAlignment alignment;
  final Color color;
  final bool showNumber;
  final bool distinct;
  final dynamic mensagem;

  MessageScaffold({
    Key? key,
    required this.mensagem,
    required this.padding,
    required this.alignment,
    required this.color,
    this.showNumber = true,
    this.distinct = false,
  }) : super(key: key);

  ContactsController contactsController = Get.find();

  @override
  Widget build(BuildContext context) {
    String data = (mensagem['date'] as String).split(' ')[1].substring(0, 5);
    String userNumber = mensagem['usuario'];
    String userName = '';
    String textoMensagem = mensagem['mensagem'];
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
      padding: padding,
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: alignment,
            children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: margin,
                    vertical: 1,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: alignment == MainAxisAlignment.start ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    children: [
                      showNumber
                          ? Text(
                              userName == '' ? userNumber : userName,
                              style: TextStyle(color: colors[int.parse(userNumber) % colors.length]),
                            )
                          : const SizedBox(),
                      mensagem['mediaLink'] != ''
                          ? TextButton(
                              onPressed: () {
                                Get.to(
                                  Scaffold(
                                    body: Center(
                                      child: Hero(
                                        tag: mensagem['mediaLink'],
                                        child: CachedNetworkImage(
                                          imageUrl: mensagem['mediaLink'],
                                          placeholder: (context, url) => const Loading(),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: mensagem['mediaLink'],
                                child: CachedNetworkImage(
                                  imageUrl: mensagem['mediaLink'],
                                  placeholder: (context, url) => const Loading(),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SelectableText(textoMensagem),
                      Text(
                        data,
                        style: TextStyle(color: Color(0xaaffffff), fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          showNumber
              ? Positioned(
                  left: margin / 4,
                  top: 1,
                  child: distinct
                      ? Container(
                          width: size * 3,
                          height: size,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: color,
                          ),
                        )
                      : const SizedBox(),
                )
              : Positioned(
                  right: margin / 4,
                  top: 1,
                  child: distinct
                      ? Container(
                          width: size * 3,
                          height: size,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: color,
                          ),
                        )
                      : const SizedBox(),
                )
        ],
      ),
    );
  }
}
