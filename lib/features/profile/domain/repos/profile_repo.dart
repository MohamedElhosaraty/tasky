import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../profile_entities/profile_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileEntity>> getProfile();
}