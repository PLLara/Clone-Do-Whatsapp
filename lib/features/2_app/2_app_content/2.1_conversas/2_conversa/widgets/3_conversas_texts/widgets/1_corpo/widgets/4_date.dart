// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

class MensagemDate extends StatelessWidget {
  const MensagemDate({
    super.key,
    required this.dia,
  });

  final String dia;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          dia,
          style: const TextStyle(
            color: Color(0xaaffffff),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
