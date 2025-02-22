import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/features/logo/presentation/cubits/logo_cubit.dart';
import 'package:tasky/features/logo/presentation/views/widgets/logo_bloc_builder.dart';
import 'package:tasky/features/logo/presentation/views/widgets/task_steps.dart';
import '../../../../../core/utils/app_text_style.dart';

class LogoViewBody extends StatefulWidget {
  const LogoViewBody({super.key});

  @override
  State<LogoViewBody> createState() => _LogoViewBodyState();
}

class _LogoViewBodyState extends State<LogoViewBody> {
  late PageController pageController;
  int currentIndex = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    pageController = PageController();
    context.read<LogoCubit>().getLogo();
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          14.verticalSpace,
          Text(
            "My Tasks",
            style: TextStyles.bold19.copyWith(color: const Color(0x6324252c)),
          ),
          16.verticalSpace,
          TaskSteps(
            currentIndex: currentIndex,
            pageController: pageController,
          ),
          Expanded(
              child: LogoBlocBuilder(
            pageController: pageController,
            formKey: formKey,
          )),
        ],
      ),
    );
  }
}
