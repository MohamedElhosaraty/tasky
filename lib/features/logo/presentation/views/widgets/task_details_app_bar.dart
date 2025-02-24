import 'package:flutter/material.dart';
import 'package:tasky/generated/assets.dart';

import '../../../../../core/utils/app_text_style.dart';
import 'menu_button.dart';

//واجهة PreferredSizeWidget تُستخدم لتحديد الحجم المفضل للـ Widget
class TaskDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskDetailsAppBar({
    super.key, required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Image.asset(Assets.imagesArrowLeft)),
        backgroundColor: Colors.white,
        title: Text(
          "Task Details",
          style: TextStyles.bold19,
        ),
        actions:  [
          MenuButton(
            userId: userId,
          ),
        ],
      ),
    );
  }

  @override
  //القيمة kToolbarHeight هي الارتفاع الافتراضي لشريط التطبيقات في تصميم الماتيريال،
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
