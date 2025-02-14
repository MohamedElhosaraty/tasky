import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/services/get_it_services.dart';
import 'package:tasky/features/auth/domain/repos/user_repository.dart';
import 'package:tasky/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:tasky/features/auth/presentation/views/widgets/sign_in_bloc_consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const routeName = 'signin';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(getIt<UserRepository>()),
      child: const Scaffold(
        body: SignInViewBlocConsumer(),
      ),
    );
  }
}
