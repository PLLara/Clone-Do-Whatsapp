import 'package:flutter/material.dart';

class GenericNullUser extends StatelessWidget {
  const GenericNullUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.person,
            size: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
