import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/auth/presentation/views/widgets/signup_bloc_consumer.dart';
import '../../../../core/services/get_it_services.dart';
import '../../domain/repos/user_repository.dart';
import '../cubits/signup_cubit/signup_cubit.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const String routeName = 'signup_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<UserRepository>()),
      child: const Scaffold(
        body: SignupViewBlocConsumer(),
      ),
    );
  }
}
