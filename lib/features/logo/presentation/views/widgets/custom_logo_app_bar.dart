import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/generated/assets.dart';

import '../../../../../core/services/shered_preferences_singleton.dart';
import '../../../../../core/utils/app_text_style.dart';
import '../../../../../core/utils/end_point.dart';
import '../../../../auth/presentation/views/signin_view.dart';
import '../../../../profile/presentation/views/profile_view.dart';
import '../../cubits/logo_cubit.dart';

//واجهة PreferredSizeWidget تُستخدم لتحديد الحجم المفضل للـ Widget
class CustomLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomLogoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "logo",
          style: TextStyles.bold24,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ProfileView.routeName);
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<LogoCubit>().logout(refreshToken: Prefs.getString(EndPoint.refreshToken));
              Navigator.pushNamed(context, SigninView.routeName);
            },
            child: Image.asset(
              Assets.imagesDeleteAccount,
              scale: .8,
            ),
          ),
        ],
      ),
    );
  }

  @override
  //القيمة kToolbarHeight هي الارتفاع الافتراضي لشريط التطبيقات في تصميم الماتيريال،
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
