import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/add_task/presentation/cubits/create_task/create_task_cubit.dart';
import 'package:tasky/features/add_task/presentation/views/widgets/add_task_view_body.dart';
import 'package:tasky/features/logo/presentation/cubits/logo_cubit.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widget/custom_progress_hud.dart';

class CreateTaskBlocConsumer extends StatelessWidget {
  const CreateTaskBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTaskCubit, CreateTaskState>(listener: (context, state) {
      if (state is CreateTaskSuccess) {
        buildErrorBar(context, 'Success');
      }
      if (state is CreateTaskFailure) {
        buildErrorBar(context, state.errorMessage);
      }
    }, builder: (context, state) {
      return CustomProgressHud(
        isLoading: state is CreateTaskLoading ? true : false,
        child: const AddTaskViewBody(),
      );
    });
  }
}
