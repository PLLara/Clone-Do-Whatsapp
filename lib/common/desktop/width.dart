import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool isDesktop(Size size) {
  return (size.width > 800) && kIsWeb;
}
