import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasky/core/helper_functions/build_error_bar.dart';
import 'package:tasky/core/widget/custom_error_widget.dart';
import 'package:tasky/features/logo/presentation/cubits/logo_cubit.dart';
import 'package:tasky/features/logo/presentation/views/widgets/task_steps_page_view.dart';

class LogoBlocBuilder extends StatelessWidget {
  const LogoBlocBuilder(
      {super.key, required this.pageController, required this.formKey});

  final PageController pageController;

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoCubit, LogoState>(
      listener: (context, state) {
        if (state is LogoSuccess) {
          if (state.source == 'local') {
            buildErrorBar(
              context,
              "⚠️ البيانات محلية بسبب فشل في الاتصال بالسيرفر: ${state.errorMessage}",
            );
          }
        }
      },
      builder: (context, state) {
        return BlocBuilder<LogoCubit, LogoState>(builder: (context, state) {
          var logoEntity = context.read<LogoCubit>().logoMap;
          if (state is LogoSuccess) {
            return TaskStepsPageView(
              pageController: pageController,
              formKey: formKey,
              logoMap: logoEntity,
            );
          } else if (state is LogoFailure) {
            return CustomErrorWidget(
              data: state.errorMessage,
            );
          } else {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Container(
                    width: 50.w,
                    height: 50.h,
                    color: Colors.white,
                  ),
                  title: Container(
                    height: 16.h,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        height: 14.h,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12.h,
                        width: 100.w,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.more_vert, color: Colors.white),
                ),
              ),
            );
          }
        });
      },
    );
  }
}
