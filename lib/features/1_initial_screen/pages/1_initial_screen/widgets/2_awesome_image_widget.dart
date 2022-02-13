// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AwesomeImage extends StatelessWidget {
  const AwesomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9999),
      child: SizedBox(
        width: 300,
        child: Image(
          color: Theme.of(context).primaryColor,
          image: const AssetImage('assets/background.png'),
        ),
      ),
    );
  }
}
