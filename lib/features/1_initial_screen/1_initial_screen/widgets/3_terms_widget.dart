// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Termos extends StatelessWidget {
  const Termos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Os termos de uso ainda terão de ser feitos.",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge
      ),
    );
  }
}