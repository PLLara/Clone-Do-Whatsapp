// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:whatsapp2/features/1_initial_screen/1_initial_screen/widgets/1_welcome_widget.dart';
import 'package:whatsapp2/features/1_initial_screen/1_initial_screen/widgets/2_awesome_image_widget.dart';
import 'package:whatsapp2/features/1_initial_screen/1_initial_screen/widgets/3_terms_widget.dart';
import 'package:whatsapp2/features/1_initial_screen/1_initial_screen/widgets/4_concordar_widget.dart';
import '../2_register_page/2_register_page.dart';

class InicialScreen extends StatelessWidget {
  const InicialScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const WelcomeToWhatsapp(),
              const AwesomeImage(),
              const Termos(),
              Concordar(
                nextScreen: RegisterPage(
                  key: const Key('register'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
