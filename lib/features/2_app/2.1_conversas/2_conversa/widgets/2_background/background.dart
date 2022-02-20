
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      fit: BoxFit.fitWidth,
      image: AssetImage('assets/fullBackground.jpg'),
    );
  }
}