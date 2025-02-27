import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/services/get_it_services.dart';
import 'package:tasky/core/widget/custom_app_bar.dart';
import 'package:tasky/features/profile/domain/repos/profile_repo.dart';
import 'package:tasky/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tasky/features/profile/presentation/views/widgets/profile_bloc_consumer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt.get<ProfileRepo>())..getProfile(),
      child: const Scaffold(
        appBar: CustomAppBar(
          title: 'Profile',
        ),
        body: ProfileBlocConsumer(),
      ),
    );
  }
}
