import 'package:dartz/dartz.dart';
import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class LogoRepo {
  Future<Either<Failure,  Map<String, Object>>> getLogoRepo();
  Future<Either<Failure, void>> editeTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String userId,
    required String status,
  });
  Future<Either<Failure, void>> deleteTask({
    required String userId,
  });

  Future<Either<Failure, void>> logout({
    required String refreshToken,
  });

  Future<Either<Failure, LogoEntity>> getOneTask({required String userId,});




}