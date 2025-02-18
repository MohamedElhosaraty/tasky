import 'package:dartz/dartz.dart';
import 'package:tasky/features/auth/domain/user_entity/signup_entity.dart';

import '../../../../core/errors/failures.dart';
import '../user_entity/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signIn(
      {required String phone, required String password});

  Future<Either<Failure, SignupEntity>> signUp({
    required String phone,
    required String password,
    required String displayName,
    required int experienceYears,
    required String address,
    required String level,
  });
}
