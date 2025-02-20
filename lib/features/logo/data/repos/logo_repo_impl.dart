import 'package:dartz/dartz.dart';

import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/logo/data/data_sources/logo_remote_data_source.dart';

import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';

import '../../domain/repos/logo_repo.dart';

class LogoRepoImpl implements LogoRepo {

  final LogoRemoteDataSource remoteDataSource;

  LogoRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LogoEntity>>> getLogoRepo() async{
    try {
      final logoList  = await remoteDataSource.getLogo();
      final List<LogoEntity> logoEntities = logoList.map((logo) => LogoEntity(
        title: logo.title ?? '',
        desc: logo.desc ?? '',
        image: logo.image ?? '',
        priority: logo.priority?.toString() ?? '0',
        status: logo.status ?? '',
        createdAt: logo.createdAt.toString(),
        updatedAt: logo.updatedAt.toString() ,
        userId: logo.id.toString() ,
      )).toList();
      return Right(logoEntities);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }


  @override
  Future<Either<Failure, void>> editeTask(
      {required String image,
        required String title,
        required String desc,
        required String priority,
        required String status,
        required String userId}) async {
    try {
      await remoteDataSource.editeTask(
          image: image,
          title: title,
          desc: desc,
          priority: priority,
          userId: userId,
          status: status);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask({required String userId}) async{
    try {
      await remoteDataSource.deleteTask(id: userId);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> logout({required String refreshToken}) async{
    try {
      await remoteDataSource.logout(refreshToken: refreshToken);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, LogoEntity>> getOneTask({required String userId}) async {
    try {
      final logo = await remoteDataSource.getOneTask(userId: userId);
      final LogoEntity logoEntity = LogoEntity(
        title: logo.title ?? '',
        desc: logo.desc ?? '',
        image: logo.image ?? '',
        priority: logo.priority?.toString() ?? '0',
        status: logo.status ?? '',
        createdAt: logo.createdAt.toString(),
        updatedAt: logo.updatedAt.toString(),
        userId: logo.id.toString(),
      );
      return Right(logoEntity);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}