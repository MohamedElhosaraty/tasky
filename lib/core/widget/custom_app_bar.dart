import 'package:flutter/material.dart';

import '../utils/app_text_style.dart';


//واجهة PreferredSizeWidget تُستخدم لتحديد الحجم المفضل للـ Widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new,
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.bold19,
      ),
    );
  }

  @override
  //القيمة kToolbarHeight هي الارتفاع الافتراضي لشريط التطبيقات في تصميم الماتيريال،
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
