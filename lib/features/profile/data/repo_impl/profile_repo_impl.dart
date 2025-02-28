import 'package:dartz/dartz.dart';
import 'package:tasky/features/profile/domain/profile_entities/profile_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repos/profile_repo.dart';
import '../data_source/profile_remote_data_source.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl({required this.profileRemoteDataSource});
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async{
    try {
      final profile = await profileRemoteDataSource.getProfile();

      final profileEntity = ProfileEntity(
        name: profile.displayName ?? '',
        experience: profile.experienceYears.toString(),
        location: profile.address ?? '',
        level: profile.level ?? '',
        phoneNumber: profile.username ?? '',
      );
      return Right(profileEntity);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}