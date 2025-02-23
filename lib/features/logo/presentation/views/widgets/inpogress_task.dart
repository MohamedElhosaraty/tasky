import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';
import 'package:tasky/features/logo/presentation/views/widgets/task_item.dart';

import '../../cubits/logo_cubit.dart';

class InpogressTask extends StatelessWidget {
  const InpogressTask({super.key, required this.logoList});

  final List<LogoEntity> logoList ;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/1.2,
      width: double.infinity,
      child: ListView.builder(
        itemCount: logoList.length,
        itemBuilder: (context, index) {
          return TaskItem(
            createdAt: logoList[index].createdAt.toString(),
            updatedAt: logoList[index].updatedAt.toString(),
            userId: logoList[index].userId.toString(),
            priority: logoList[index].priority.toString(),
            status: logoList[index].status.toString(),
            image: logoList[index].image.toString(),
            title:  logoList[index].title,
            desc: logoList[index].desc,
            colorProcess: context.read<LogoCubit>().updateColorBasedOnStatus(logoList[index].status),
            textProcess: logoList[index].status,
            colorFlag: context.read<LogoCubit>().updateColorBasedOnPriority(logoList[index].priority),
            textLevel: logoList[index].priority.toString(),
            history: dateTime(index),
          );
        },
      ),
    );
  }
  String dateTime(int index) {
    DateTime dataTime = DateTime.parse(logoList[index].createdAt);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dataTime);
    return formattedDate;

  }
}
