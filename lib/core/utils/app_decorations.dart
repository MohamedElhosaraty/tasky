import 'package:flutter/material.dart';

abstract class AppDecorations {
  static var grayBoxDecoration = ShapeDecoration(
    color: Color(0x7FF2F3F3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
  );
}