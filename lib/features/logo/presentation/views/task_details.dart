import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';
import 'package:tasky/features/logo/presentation/cubits/logo_cubit.dart';
import 'package:tasky/features/logo/presentation/views/widgets/task_details_app_bar.dart';
import 'package:tasky/features/logo/presentation/views/widgets/task_details_build_consumer.dart';

import '../../../../core/services/get_it_services.dart';
import '../../domain/repos/logo_repo.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.logoEntity});

  static const routeName = 'task_details';
  final LogoEntity logoEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoCubit(getIt<LogoRepo>()),
      child: Scaffold(
        appBar: TaskDetailsAppBar(
          userId: logoEntity.userId,
        ),
        body: TaskDetailsBuildConsumer(logoEntity: logoEntity,),
      ),
    );
  }
}
