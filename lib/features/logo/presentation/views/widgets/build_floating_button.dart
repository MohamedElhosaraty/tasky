import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/utils/app_color.dart';
import 'package:tasky/features/logo/presentation/views/qr_scanner_view.dart';

import '../../../../add_task/presentation/views/add_task_view.dart';

class BuildFloatingButton extends StatelessWidget {
  const BuildFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 35.r,
          backgroundColor: Colors.white,
          child: IconButton(
            color: AppColor.primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, QRScannerView.routeName);
            },
            icon: const Icon(
              Icons.qr_code_2,
            ),
          ),
        ),
        10.verticalSpace,
        CircleAvatar(
          backgroundColor: AppColor.primaryColor,
          radius: 35.r,
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AddTaskView.routeName);
            },
            child: const Icon(
              size: 32,
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
  }

