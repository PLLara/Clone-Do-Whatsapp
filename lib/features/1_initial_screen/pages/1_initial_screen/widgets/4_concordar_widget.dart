// ignore: must_be_immutable
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Concordar extends StatelessWidget {
  final Route nextScreen;

  const Concordar({
    Key? key,
    required this.nextScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              nextScreen,
            );
          },
          child: const Text("CONCORDAR E AVANÇAR"),
        ),
      ),
    );
  }
}
