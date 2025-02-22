import 'package:flutter/material.dart';
import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';
import 'package:tasky/features/logo/presentation/views/widgets/all_task.dart';
import 'package:tasky/features/logo/presentation/views/widgets/finished_task.dart';
import 'package:tasky/features/logo/presentation/views/widgets/inpogress_task.dart';
import 'package:tasky/features/logo/presentation/views/widgets/waiting_task.dart';

class TaskStepsPageView extends StatelessWidget {
  const TaskStepsPageView({super.key, required this.pageController, required this.formKey, required this.logoMap, });

  final PageController pageController;

  final GlobalKey<FormState> formKey ;

  final Map<String, List<LogoEntity>> logoMap ;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0,),
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: getPages(logoMap).length,
        itemBuilder: (context, index) {
          return getPages(logoMap)[index];
        },
      ),
    );
  }

  List<Widget> getPages(Map<String, List<LogoEntity>> logoEntity) {
    return [
      AllTask(logoList: logoEntity["All"]!.toList(),),
      InpogressTask(logoList: logoEntity["Inpogress"]!.toList(),),
      WaitingTask(logoList: logoEntity["waiting"]!.toList(),),
      FinishedTask(logoList: logoEntity["Finished"]!.toList(),),
    ];
  }
}