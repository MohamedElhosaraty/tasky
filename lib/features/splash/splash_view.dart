import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_color.dart';
import 'package:tasky/features/splash/widget/custom_splash_text.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static const String routeName = 'SplashView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: CustomSplashText(),
    );
  }
}
