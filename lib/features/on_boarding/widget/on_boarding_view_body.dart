import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/services/shered_preferences_singleton.dart';
import 'package:tasky/core/utils/end_point.dart';
import 'package:tasky/features/auth/presentation/views/signin_view.dart';
import 'package:tasky/features/logo/presentation/views/logo_view.dart';
import 'package:tasky/generated/assets.dart';

import '../../../core/utils/app_text_style.dart';
import '../../../core/widget/custom_button.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            Assets.imagesPrimaryImage,
            fit: BoxFit.cover,
            height: 482.w,
          ),
          const Text(
            "Task Management & \n To-Do List",
            textAlign: TextAlign.center,
            style: TextStyles.bold24,
          ),
          16.verticalSpace,
          Text(
            """This productive tool is designed to help \nyou better manage your task\n project-wise conveniently!""",
            textAlign: TextAlign.center,
            style: TextStyles.regular14.copyWith(color: const Color(0xff6E6A7C)),
          ),
          33.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: CustomButton(onPressed: (){
              var token = Prefs.getString(EndPoint.token);
              if(token.isNotEmpty){
                Navigator.pushReplacementNamed(context, LogoView.routeName);
              }else{
                Navigator.pushReplacementNamed(context, SigninView.routeName);
              }
            }, text: "Get Started",),
          ),
        ],
      ),
    );
  }
}
