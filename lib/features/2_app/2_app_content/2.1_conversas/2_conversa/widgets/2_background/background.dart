import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      color: Color(0xff1b2830),
      repeat: ImageRepeat.repeat,
      image: AssetImage('assets/fullBackground.jpg'),
    );
  }
}
