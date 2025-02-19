import 'package:flutter/material.dart';
import 'package:tasky/generated/assets.dart';

import '../utils/app_text_style.dart';

//واجهة PreferredSizeWidget تُستخدم لتحديد الحجم المفضل للـ Widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key, required this.title,
  });

  final String title ;

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
          title,
          style: TextStyles.bold19,
        ),
      ),
    );
  }

  @override
  //القيمة kToolbarHeight هي الارتفاع الافتراضي لشريط التطبيقات في تصميم الماتيريال،
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
