import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/services/get_it_services.dart';
import 'package:tasky/features/logo/domain/repos/logo_repo.dart';
import 'package:tasky/features/logo/presentation/cubits/logo_cubit.dart';
import 'package:tasky/features/logo/presentation/views/widgets/build_floating_button.dart';
import 'package:tasky/features/logo/presentation/views/widgets/custom_logo_app_bar.dart';
import 'package:tasky/features/logo/presentation/views/widgets/logo_view_body.dart';


class LogoView extends StatelessWidget {
  const LogoView({super.key});

  static const routeName = 'logo';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoCubit(getIt<LogoRepo>()),
      child: const Scaffold(
        appBar: CustomLogoAppBar(),
        body: LogoViewBody(),
        floatingActionButton: BuildFloatingButton(),
      ),
    );
  }
}
