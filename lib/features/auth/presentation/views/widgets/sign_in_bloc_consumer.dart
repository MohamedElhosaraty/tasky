import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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