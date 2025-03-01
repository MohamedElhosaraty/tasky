import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:tasky/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:tasky/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:tasky/features/logo/presentation/views/logo_view.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widget/custom_progress_hud.dart';

class SignInViewBlocConsumer extends StatelessWidget {
  const SignInViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(listener: (context, state) {
      if (state is SigninSuccess) {
        Navigator.pushNamed(context, LogoView.routeName);

        const options = ConfettiOptions(
            spread: 360,
            ticks: 50,
            gravity: 0,
            decay: 0.94,
            startVelocity: 30,
            colors: [
              Color(0xffFFE400),
              Color(0xffFFBD00),
              Color(0xffE89400),
              Color(0xffFFCA6C),
              Color(0xffFDFFB8)
            ]);


        shoot() {
          Confetti.launch(context,
              options:
              options.copyWith(particleCount: 40, scalar: 1.2),
              particleBuilder: (index) => Star());
          Confetti.launch(context,
              options: options.copyWith(
                particleCount: 10,
                scalar: 0.75,
              ),
              particleBuilder: (index) => Star());
        }

        Timer(Duration.zero, shoot);
        Timer(const Duration(milliseconds: 100), shoot);
        Timer(const Duration(milliseconds: 200), shoot);
        buildErrorBar(context, 'Success');
      }
      if (state is SigninFailure) {
        buildErrorBar(context, state.errorMessage);
      }
    }, builder: (context, state) {
      return CustomProgressHud(
        isLoading: state is SigninLoading ? true : false,
        child: const SigninViewBody(),
      );
    });
  }
}