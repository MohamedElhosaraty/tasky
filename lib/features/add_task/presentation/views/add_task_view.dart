import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/services/get_it_services.dart';
import 'package:tasky/features/add_task/domain/repos/create_task_repo.dart';
import 'package:tasky/features/add_task/presentation/cubits/create_task/create_task_cubit.dart';
import 'package:tasky/features/add_task/presentation/views/widgets/create_task_bloc_consumer.dart';
import 'package:tasky/core/widget/custom_app_bar.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  static const routeName = 'AddTaskView';


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskCubit(getIt<CreateTaskRepo>()),
      child: const Scaffold(
        appBar: CustomAppBar(
          title: "Add New Task",
        ),
        body: CreateTaskBlocConsumer(),
      ),
    );
  }
}
