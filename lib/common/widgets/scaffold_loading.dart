import 'package:flutter/material.dart';

class ScaffoldLoading extends StatelessWidget {
  const ScaffoldLoading({
    super.key,
  });

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