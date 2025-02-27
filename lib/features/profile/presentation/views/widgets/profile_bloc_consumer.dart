import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasky/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tasky/features/profile/presentation/views/widgets/profile_view_body.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/utils/app_text_style.dart';

class ProfileBlocConsumer extends StatelessWidget {
  const ProfileBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
      if (state is ProfileSuccess) {
        buildErrorBar(context, 'Success');
      }
      if (state is ProfileFailure) {
        buildErrorBar(context, state.errorMessage);
      }
    }, builder: (context, state) {
      if (state is ProfileSuccess) {
        return ProfileViewBody(profileEntity: state.profileEntity);
      } else if (state is ProfileFailure) {
        return Text(
          state.errorMessage,
          style: TextStyles.bold23.copyWith(color: Colors.red),
        );
      } else {
        return ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100.h,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16.h,
                    width: 80.w,
                    color: Colors.white,
                  ),
                  10.verticalSpace,
                  Container(
                    height: 16.h,
                    width: 120.w,
                    color: Colors.white,
                  ),

                ],
              ),
            ),
          ),
        );
      }
    },
    );
  }
}
