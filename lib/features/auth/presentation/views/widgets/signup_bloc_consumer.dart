import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:tasky/features/logo/presentation/views/logo_view.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widget/custom_progress_hud.dart';
import '../../cubits/signup_cubit/signup_cubit.dart';

class SignupViewBlocConsumer extends StatelessWidget {
  const SignupViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(listener: (context, state) {
      if (state is SignupSuccess) {
        Navigator.pushNamed(context, LogoView.routeName);
        buildErrorBar(context, 'Success');
      }
      if (state is SignupFailure) {
        buildErrorBar(context, state.errorMessage);
      }
    }, builder: (context, state) {
      return CustomProgressHud(
        isLoading: state is SignupLoading ? true : false,
        child: const SignupViewBody(),
      );
    });
  }
}
