import 'package:flutter/material.dart';

import 'active_step_item.dart';
import 'in_active_step_item.dart';

class StepItem extends StatelessWidget {
  const StepItem(
      {super.key,
        required this.index,
        required this.text,
        required this.isActive});

  final String index, text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: InActiveStepItem(text: text),
      secondChild: ActiveStepItem(text: text),
      crossFadeState:
      isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}