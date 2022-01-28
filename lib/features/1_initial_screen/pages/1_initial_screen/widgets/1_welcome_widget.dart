// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WelcomeToWhatsapp extends StatelessWidget {
  const WelcomeToWhatsapp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Welcome to Whatsapp",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}