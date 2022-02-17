import 'package:flutter/material.dart';

class ScaffoldLoading extends StatelessWidget {
  const ScaffoldLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}