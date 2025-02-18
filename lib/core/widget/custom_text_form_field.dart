import 'package:flutter/material.dart';

import '../utils/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.keyboardInputType,
      this.suffixIcon, this.onSaved,
        this.obscureText = false,
        this.maxLines = 1,
        this.initialValue,
        this.style
      });

  final String hintText;
  final TextInputType keyboardInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final int maxLines;
  final String? initialValue;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      initialValue: initialValue,
      style: style,
      maxLines: maxLines,

      onSaved: onSaved,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      keyboardType: keyboardInputType,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF9FAFA),
        hintText: hintText,
        hintStyle: TextStyles.bold13.copyWith(
          color: const Color(0xff949D9E),
        ),
        suffixIcon: suffixIcon,
        border: buildBorder(),
        focusedBorder: buildBorder(),
        enabledBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return  OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFE6E9E9),
      ),
    );
  }
}
