// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/desktop/width.dart';
import 'package:whatsapp2/common/navigator/go_to_page.dart';
import 'package:whatsapp2/common/widgets/generic_null_user.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/conversa_page.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/model/message_model.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.3_contatos/contatos_page.dart';
import 'package:whatsapp2/model/conversa.dart';
import 'package:whatsapp2/state/global/contacts_state.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';
import 'package:whatsapp2/state/local/conversa_state.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.3_contatos/widgets/contacts_list_view/widgets/user_description_widget.dart';
import 'package:whatsapp2/state/desktop/selected_conversa_state.dart';

class SemConversasCriarNovaWidget extends StatelessWidget {
  const SemConversasCriarNovaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nenhuma conversa encontrada",
              style: Theme.of(context).textTheme.headline1,
            ),
            ElevatedButton(
              onPressed: () {
                goToPage(Contatos(), Get.to);
              },
              child: Text(
                "Criar nova conversa",
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (e) => AlertDialog(
                    title: Text(
                      "PERIGO",
                      style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Essa conversa possui carater irrestrito para fins de teste! As mensagens aqui disponibilizadas não são de minha responsabilidade, não possuem fiscalização ativa e podem conter: Palavras de baixo calão, imagens pornográficas e conteúdo questionável. ENTRE POR SUA CONTA E RISCO.",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              Get.find<ConversasPathController>().addConversaGeral();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Entrar por minha conta e risco"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("VOLTAR AO APP"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text(
                "Adicionar conversa geral",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ConversaListTile extends StatefulWidget {
  const ConversaListTile({
    Key? key,
    required this.conversaPath,
  }) : super(key: key);

  final ConversaPathData conversaPath;

  @override
  State<ConversaListTile> createState() => _ConversaListTileState();
}

class _ConversaListTileState extends State<ConversaListTile> {
  final ContactsController contactsController = Get.find<ContactsController>();

  @override
  Widget build(BuildContext context) {
    // * Setting variables:
    Get.put(
      ConversaController(route: widget.conversaPath.conversaId),
      tag: widget.conversaPath.conversaId,
    );

    // ! Código horrível :/
    var otherPessoa = Contact();
    otherPessoa = contactsController.procurarContatoDoDestinatario(widget.conversaPath, otherPessoa);
    if (widget.conversaPath.isConversaPrivate) {
      return ConversaListTileGeneric(
        conversaPath: widget.conversaPath,
        injectedConversaPhoto: UserPhotoOrPlaceholder(
          contact: otherPessoa,
          key: Key(
            otherPessoa.toString(),
          ),
        ),
        injectedTitle: Text(
          otherPessoa.displayName,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
    }

    return ConversaListTileGeneric(
      conversaPath: widget.conversaPath,
      injectedConversaPhoto: const GenericNullUser(),
      injectedTitle: Text(
        widget.conversaPath.titulo,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class ConversaListTileGeneric extends StatefulWidget {
  const ConversaListTileGeneric({
    Key? key,
    required this.conversaPath,
    required this.injectedConversaPhoto,
    required this.injectedTitle,
  }) : super(key: key);

  final ConversaPathData conversaPath;
  final Widget injectedConversaPhoto;
  final Widget injectedTitle;

  @override
  State<ConversaListTileGeneric> createState() => _ConversaListTileGenericState();
}

class _ConversaListTileGenericState extends State<ConversaListTileGeneric> {
  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: widget.conversaPath.conversaId,
    );

    MessageModel ultimaMensagem;
    try {
      ultimaMensagem = conversaController.papo.last;
    } catch (e) {
      ultimaMensagem = MessageModel(id: '', date: DateTime.now(), message: '', mediaLink: '', usuario: '', metaData: null);
    }
    return ListTile(
      leading: widget.injectedConversaPhoto,
      title: widget.injectedTitle,
      subtitle: Obx(
        () {
          var contactsController = Get.find<ContactsController>();
          try {
            ultimaMensagem = conversaController.papo.first;
          } catch (e) {
            ultimaMensagem = MessageModel(id: '', date: DateTime.now(), message: '', mediaLink: '', usuario: '', metaData: null);
          }
          return Text(
            "${contactsController.getNameBasedOnNumber(ultimaMensagem.usuario)}: ${ultimaMensagem.message}",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w200,
            ),
          );
        },
      ),
      onLongPress: () {
        var isUndeletableConversa = widget.conversaPath.conversaId == 'geral';
        showDialog(
          context: context,
          builder: (e) => AlertDialog(
            title: widget.injectedTitle,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    var conversaController = Get.find<ConversasPathController>();
                    if (isUndeletableConversa) {
                      conversaController.removeConversaGeral();
                    } else {
                      conversaController.removeConversa(widget.conversaPath.conversaId, widget.conversaPath.isConversaPrivate);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text("Excluir conversa"),
                ),
                isUndeletableConversa
                    ? const Text("")
                    : const Text(
                        "Esse processo excluirá a conversa permanentemente para TODOS os usuários",
                        textAlign: TextAlign.center,
                      ),
              ],
            ),
          ),
        );
      },
      trailing: MensagensNaoLidasEDataWidget(
        dateTime: ultimaMensagem.date,
        conversaPath: widget.conversaPath,
      ),
      onTap: () async {
        // ! Definindo as variaveis
        var conversaController = Get.find<ConversaController>(tag: widget.conversaPath.conversaId);
        final desktopSelectedConversaController = Get.find<DesktopSelectedConversaController>();

        // ! Definindo a conversa
        var newConversa = Conversa(
          path: widget.conversaPath,
          key: Key(widget.conversaPath.conversaId),
          injectedConversaPhoto: widget.injectedConversaPhoto,
          injectedTitle: widget.injectedTitle,
        );

        if (conversaController.quantidadeDeMensagensNaoLidas.value != 0) {
          conversaController.quantidadeDeMensagensNaoLidas.value = 0;
        }

        if (isDesktop(MediaQuery.of(context).size)) {
          return desktopSelectedConversaController.updateSelectedWidget(newConversa);
        }

        Get.to(() => newConversa);
      },
    );
  }
}

class MensagensNaoLidasEDataWidget extends StatelessWidget {
  const MensagensNaoLidasEDataWidget({
    Key? key,
    required this.dateTime,
    required this.conversaPath,
  }) : super(key: key);

  final DateTime dateTime;
  final ConversaPathData conversaPath;

  @override
  Widget build(BuildContext context) {
    final ConversaController conversaController = Get.find<ConversaController>(
      tag: conversaPath.conversaId,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Obx(
          () {
            if (conversaController.quantidadeDeMensagensNaoLidas.value == 0) {
              return Text(
                '${dateTime.hour}:${dateTime.minute}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              );
            } else {
              return Text(
                '${dateTime.hour}:${dateTime.minute}',
                style: TextStyle(
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(
          () {
            if (conversaController.quantidadeDeMensagensNaoLidas.value == 0) {
              return Container(
                constraints: const BoxConstraints(
                  minHeight: 18,
                  minWidth: 18,
                  maxWidth: 18,
                ),
              );
            }
            return Container(
              constraints: const BoxConstraints(
                minHeight: 18,
                minWidth: 18,
                maxWidth: 18,
              ),
              decoration: BoxDecoration(
                color: context.theme.primaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    conversaController.quantidadeDeMensagensNaoLidas.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
