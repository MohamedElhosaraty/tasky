import 'package:flutter/material.dart';
import 'package:tasky/features/profile/domain/profile_entities/profile_entity.dart';
import 'package:tasky/features/profile/presentation/views/widgets/custom_profile_item.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.profileEntity});

  final ProfileEntity profileEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
           CustomProfileItem(
               title: "NAME",
               subtitle: profileEntity.name,),
          CustomProfileItem(
              isPhone: true, title: "PHONE", subtitle: profileEntity.phoneNumber),
           CustomProfileItem(
              title: "LEVEL", subtitle: profileEntity.level),
           CustomProfileItem(
              title: "YEAR OF EXPERIENCE", subtitle: profileEntity.experience),
           CustomProfileItem(
              title: "LOCATION", subtitle: profileEntity.location),
          const Spacer(),
        ],
      ),
    );
  }
}
