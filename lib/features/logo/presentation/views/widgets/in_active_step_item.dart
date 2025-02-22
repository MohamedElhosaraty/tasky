import 'package:flutter/material.dart';
import '../../../../../core/utils/app_text_style.dart';

class InActiveStepItem extends StatelessWidget {
  const InActiveStepItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.semiBold16.copyWith(color: const Color(0xff7C7C80)),
    );
  }
}