import 'package:flutter/material.dart';
import 'package:tasky/features/on_boarding/widget/on_boarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  static const routeName = 'on-boarding';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnBoardingViewBody(),
    );
  }
}
