import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/state/path_cubit.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/1_appbar/appbar.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/2_background/background.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/3_conversas_texts/conversa_texts.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/4_bottom_form/bottom_form.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';

class Conversa extends StatefulWidget {
  final ConversaPathData path;
  const Conversa({
    Key? key,
    required this.path,
    required this.injectedConversaPhoto,
    required this.injectedTitle,
  }) : super(key: key);
  final Widget injectedConversaPhoto;
  final Widget injectedTitle;

  @override
  State<Conversa> createState() => _ConversaState();
}

class _ConversaState extends State<Conversa> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PathCubit(widget.path),
      child: Scaffold(
        backgroundColor: const Color(0xff0B141A),
        appBar: ConversaAppBarBind(
          injectedConversaPhoto: widget.injectedConversaPhoto,
          injectedTitle: widget.injectedTitle,
        ),
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
        const Background(),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: const [
            ConversaTexts(),
            BottomForm()
          ],
        ),
      ],
    );
  }
}
