import 'package:flutter/material.dart';
import 'package:tasky/features/logo/presentation/views/widgets/step_item.dart';

class TaskSteps extends StatelessWidget {
  const TaskSteps(
      {super.key,
        required this.currentIndex,
        required this.pageController,
       });

  final int currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          getSteps().length,
              (index) {
            return GestureDetector(
              onTap: () {
                pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              child: StepItem(
                isActive: index == currentIndex,//currentIndex,
                index: (index + 1).toString(),
                text: getSteps()[index],
              ),
            );
          },
        ));
  }
}

List<String> getSteps() {
  return [
    "All",
    "Inpogress",
    "Waiting",
    "Finished",
  ];
}