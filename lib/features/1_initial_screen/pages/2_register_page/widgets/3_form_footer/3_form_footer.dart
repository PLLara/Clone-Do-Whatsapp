// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  const FormFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        "Você receberá um sms em instantes",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
