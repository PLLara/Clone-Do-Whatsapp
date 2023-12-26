// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/model/message_model.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/widgets/0_base/wrapper_message.dart';
import 'package:whatsapp2/state/local/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/state/path_cubit.dart';

class ConversaMessages extends StatelessWidget {
  const ConversaMessages({
    super.key,
  });

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
            itemCount: conversaController.papo.length + 1,
            itemBuilder: (e, index) {
              if (index == 0) {
                return const SizedBox(
                  height: 30,
                );
              }
              return MensagemWidget(
                mensagens: conversaController.papo.value,
                index: index - 1,
                key: Key(
                  mensageKey(index - 1),
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // *
    var mensagem = mensagens[index];
    var mensagemAnterior = index < mensagens.length - 1 ? mensagens[index + 1] : mensagens[index];
    var isMyMessage = mensagem.usuario == FirebaseAuth.instance.currentUser?.phoneNumber;
    var isDistinct = mensagem.usuario != mensagemAnterior.usuario;

    // *
    if (isMyMessage) {
      return WrapperMyMessageScaffold(mensagem: mensagem, distinct: isDistinct);
    }
    return WrapperNotMyMessageScaffold(mensagem: mensagem, distinct: isDistinct);
  }
}
