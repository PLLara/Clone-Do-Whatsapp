// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

Positioned MensagemPeteco(bool showNumber, double MARGIN, bool distinct, double SIZE, Color color) {
  return showNumber
      ? Positioned(
          left: MARGIN / 4,
          top: 1,
          child: distinct
              ? Container(
                  width: SIZE * 3,
                  height: SIZE,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: color,
                  ),
                )
              : const SizedBox(),
        )
      : Positioned(
          right: MARGIN / 4,
          top: 1,
          child: distinct
              ? Container(
                  width: SIZE * 3,
                  height: SIZE,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: color,
                  ),
                )
              : const SizedBox(),
        );
}
