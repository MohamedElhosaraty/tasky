import 'dart:developer';

import 'package:tasky/core/utils/end_point.dart';
import 'package:tasky/features/auth/data/model/signup_model.dart';

import '../../../../core/errors/server_failure.dart';
import '../../../../core/services/api_service.dart';
import '../model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signIn({required String phone, required String password});

  Future<SignupModel> signUp({
    required String phone,
    required String password,
    required String displayName,
    required int experienceYears,
    required String address,
    required String level,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiService apiService;

  UserRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserModel> signIn(
      {required String phone, required String password}) async {
    try {
      final response = await apiService.postRequest(
        EndPoint.login,
        data: {"phone": phone, "password": password},
      );

      final Map<String, dynamic> data = response.data;

      //تحويل ال json إلى الـ UserModel
      return UserModel.fromJson(data);
    } on ServerFailure catch (e) {
      rethrow; // سيتم التعامل معه في طبقة الـ Repository
    }
  }

  @override
  Future<SignupModel> signUp(
      {required String phone,
      required String password,
      required String displayName,
      required int experienceYears,
      required String address,
      required String level}) async {
    try {
      final response = await apiService.postRequest(
        EndPoint.signup,
        data: {
          "phone": phone,
          "password": password,
          "displayName": displayName,
          "experienceYears": experienceYears,
          "address": address,
          "level": level
        },
      );

      final Map<String, dynamic> data = response.data;

      //تحويل ال json إلى الـ UserModel
      return SignupModel.fromJson(data);
    } on ServerFailure catch (e) {
      log(e.message.toString());
      rethrow; // سيتم التعامل معه في طبقة الـ Repository
    }
  }
}
