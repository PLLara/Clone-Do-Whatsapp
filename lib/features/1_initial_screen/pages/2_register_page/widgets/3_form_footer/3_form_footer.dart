import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  const FormFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Text("Tu vai receber um sms ai se pa"),
    );
  }
}
