import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/helper_functions/build_error_bar.dart';
import 'package:tasky/core/utils/app_color.dart';
import 'package:tasky/core/utils/app_text_style.dart';

class CustomProfileItem extends StatelessWidget {
  const CustomProfileItem(
      {super.key,
      required this.title,
      required this.subtitle,
      this.isPhone = false});

  final String title, subtitle;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      height: 85.h,
      width: double.infinity,
      color: const Color(0xffF5F5F5),
      child: isPhone ? ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style:
          TextStyles.semiBold13.copyWith(color: const Color(0xff2F2F2F)),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyles.bold19.copyWith(color: const Color(0xff2F2F2F)),
        ),
        trailing: GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: subtitle));
            buildErrorBar(context, "Copied to $subtitle");
          },
          child: const Icon(
            Icons.copy_outlined,
            color: AppColor.primaryColor,
          ),
        ),
      ) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style:
                TextStyles.semiBold13.copyWith(color: const Color(0xa52f2f2f)),
          ),
          5.verticalSpace,
          Text(
            subtitle,
            style: TextStyles.bold19.copyWith(color: const Color(0xff2F2F2F)),
          ),
        ],
      ),
    );
  }
}
