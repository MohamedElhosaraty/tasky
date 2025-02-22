import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';
import 'package:tasky/features/logo/presentation/views/widgets/menu_button.dart';
import 'package:tasky/generated/assets.dart';
import '../../../../../core/utils/app_text_style.dart';
import '../task_details.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.textProcess,
    required this.colorProcess,
    required this.colorFlag,
    required this.textLevel,
    required this.history,
    required this.title,
    required this.desc,
    required this.image,
    required this.priority,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String textProcess;

  final Color colorProcess;
  final Color colorFlag;
  final String priority;
  final String status;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final String textLevel;
  final String history;
  final String title;
  final String desc;
  final String image;
  final int maxLength = 13;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, TaskDetails.routeName,
              arguments: LogoEntity(
                  title: title,
                  desc: desc,
                  image: image,
                  priority: priority,
                  userId: userId,
                  status: status,
                  createdAt: createdAt,
                  updatedAt: updatedAt));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 100.h,
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.file(
                    File(
                      image,
                    ),
                    scale: .1,
                    fit: BoxFit.cover,
                  ),
                ),),
            10.horizontalSpace,
            Expanded(
              flex: 18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title.length > maxLength
                            ? '${title.substring(0, maxLength)}...'
                            : title,
                        style: TextStyles.bold16,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        textProcess,
                        style:
                            TextStyles.semiBold16.copyWith(color: colorProcess),
                      ),
                    ],
                  ),
                  Text(
                    desc,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.semiBold16
                        .copyWith(color: const Color(0xff7C7C80)),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Assets.imagesFlag,
                        color: colorFlag,
                      ),
                      5.horizontalSpace,
                      Text(
                        textLevel,
                        style: TextStyles.semiBold16.copyWith(color: colorFlag),
                      ),
                      const Spacer(),
                      Text(
                        history,
                        style: TextStyles.semiBold13
                            .copyWith(color: const Color(0xff7C7C80)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            MenuButton(
              userId: userId,
            ),
          ],
        ),
      ),
    );
  }
}
