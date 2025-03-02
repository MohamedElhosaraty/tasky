import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/logo/presentation/cubits/logo_cubit.dart';
import 'package:tasky/features/logo/presentation/views/logo_view.dart';
import 'package:tasky/features/logo/presentation/views/widgets/task_details_body.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widget/custom_progress_hud.dart';
import '../../../domain/logo_entity/logo_entity.dart';

class TaskDetailsBuildConsumer extends StatelessWidget {
  const TaskDetailsBuildConsumer({super.key, required this.logoEntity});

  final LogoEntity logoEntity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoCubit, LogoState>(listener: (context, state) {
      if (state is EditTaskSuccess) {
        Navigator.pushNamed(context, LogoView.routeName);
        context.read<LogoCubit>().getLogo();
        buildErrorBar(context, 'Success');
      }
      if (state is EditTaskFailure) {
        buildErrorBar(context, state.errorMessage);
      }
    }, builder: (context, state) {
      return CustomProgressHud(
        isLoading: state is EditTaskLoading ? true : false,
        child: TaskDetailsBody(logoEntity: logoEntity),
      );
    });
  }
}
