import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColor.primaryColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.bold19.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
