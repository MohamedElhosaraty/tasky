import 'package:dartz/dartz.dart';
import 'package:tasky/core/services/shered_preferences_singleton.dart';
import 'package:tasky/core/utils/end_point.dart';
import 'package:tasky/features/auth/domain/user_entity/signup_entity.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repos/user_repository.dart';
import '../../domain/user_entity/user.dart';
import '../data_sources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> signIn(
      {required String phone, required String password}) async {
    try {
      // إرسال بيانات تسجيل الدخول إلى الـ API واسترجاع بيانات المستخدم
      final userModel =
          await remoteDataSource.signIn(phone: phone, password: password);

      Prefs.setString(EndPoint.token, userModel.accessToken!);

      Prefs.setString( EndPoint.refreshToken, userModel.refreshToken!);

      // تحويل ال userModel إلى الـ User
      final user = User(
        id: userModel.id!,
        token: userModel.accessToken!,
      );
      return Right(user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, SignupEntity>> signUp({
    required String phone,
    required String password,
    required String displayName,
    required int experienceYears,
    required String address,
    required String level,
  }) async {
    try {
      final signupModel = await remoteDataSource.signUp(
        phone: phone,
        password: password,
        displayName: displayName,
        experienceYears: experienceYears,
        address: address,
        level: level,
      );

      Prefs.setString(EndPoint.token, signupModel.accessToken!);

      Prefs.setString( EndPoint.refreshToken, signupModel.refreshToken!);



      final newUser = SignupEntity(
        id: signupModel.id!,
        accessToken: signupModel.accessToken!,
        refreshToken: signupModel.refreshToken!,
        displayName: signupModel.displayName!,
      );
      return Right(newUser);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
