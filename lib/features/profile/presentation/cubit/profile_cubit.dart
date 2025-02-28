import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/profile/domain/repos/profile_repo.dart';

import '../../domain/profile_entities/profile_entity.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final ProfileRepo profileRepo;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await profileRepo.getProfile();

    result.fold(
      (failure) => emit(ProfileFailure(errorMessage: failure.toString())),
      (profile) => emit(ProfileSuccess(profileEntity: profile)),
    );
  }
}
