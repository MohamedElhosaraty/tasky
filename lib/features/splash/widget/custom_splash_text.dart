import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/features/on_boarding/on_boarding_view.dart';

import '../../../core/utils/app_color.dart';

class CustomSplashText extends StatefulWidget {
  const CustomSplashText({super.key});

  @override
  State<CustomSplashText> createState() => _CustomSplashTextState();
}

class _CustomSplashTextState extends State<CustomSplashText> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    }, );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32.sp,
            fontWeight: FontWeight.w800,
          ),
         children: [
            TextSpan(
              text: 'y',
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
          ),
        );
  }
}
