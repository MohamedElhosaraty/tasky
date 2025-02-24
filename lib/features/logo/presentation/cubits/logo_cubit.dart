import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_color.dart';
import 'package:tasky/features/logo/domain/repos/logo_repo.dart';

import '../../domain/logo_entity/logo_entity.dart';

part 'logo_state.dart';

class LogoCubit extends Cubit<LogoState> {
  LogoCubit(this.logoRepo) : super(LogoInitial());

  final LogoRepo logoRepo;
  late Map<String, List<LogoEntity>> logoMap = {};
  late Color color;

  Color updateColorBasedOnPriority(String priority ) {
    if (priority.toLowerCase() == "high" ) {
      return color = AppColor.highAndWaitingColor;
    } else if (priority.toLowerCase() == "low") {
     return color = AppColor.lowAndFinishedColor;
    } else {
      return color = AppColor.mediumAndInprogressColor;
    }
  }
  Color updateColorBasedOnStatus(String status) {
    if (status.toLowerCase() == "waiting") {
      return color = AppColor.highAndWaitingColor;
    } else if (status.toLowerCase() == "finished") {
     return color = AppColor.lowAndFinishedColor;
    } else {
      return color = AppColor.mediumAndInprogressColor;
    }
  }




  Future<void> getLogo() async {
    emit(LogoLoading());
    final result = await logoRepo.getLogoRepo();

    result.fold((failure) => emit(LogoFailure(errorMessage: failure.message)),
        (logo) {

          final List<LogoEntity> logoList = logo['data'] as List<LogoEntity>;
          final String source = logo['source'] as String;
          final String? errorMessage = logo['errorMessage'] as String?;

          logoMap = {
        'Inpogress': [],
        'waiting': [],
        'Finished': [],
        "All": logoList,
      };

      for (var sectionLogo in logoList) {
        if (sectionLogo.status == 'Finished' ||
            sectionLogo.status == 'finished') {
          logoMap['Finished']?.add(sectionLogo);
        } else if (sectionLogo.status == 'waiting') {
          logoMap['waiting']?.add(sectionLogo);
        } else {
          logoMap['Inpogress']?.add(sectionLogo);
        }
      }

      emit(LogoSuccess(logoEntity: logoList, source: source, errorMessage: errorMessage));
    });
  }

  Future<void> editeTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String userId,
    required String status,
  }) async {
    emit(EditTaskLoading());
    final result = await logoRepo.editeTask(
      image: image,
      title: title,
      desc: desc,
      priority: priority,
      userId: userId,
      status: status,

    );
    result.fold(
            (failure) => emit(EditTaskFailure(errorMessage: failure.message)),
            (createTaskEntity) =>
            emit(EditTaskSuccess())
    );
  }


  Future<void> deleteTask({required String userId}) async {
    emit(DeleteTaskLoading());
    final result = await logoRepo.deleteTask(userId: userId);
    result.fold(
            (failure) => emit(DeleteTaskFailure(errorMessage: failure.message)),
            (createTaskEntity) =>
            emit(DeleteTaskSuccess())
    );
  }

  Future<void> logout({required String refreshToken}) async {
    emit(LogoutLoading());
    final result = await logoRepo.logout(refreshToken: refreshToken);
    result.fold(
            (failure) => emit(LogoutFailure(errorMessage: failure.message)),
            (createTaskEntity) =>
            emit(LogoutSuccess())
    );
  }

  Future<void> getOneTask({required String userId}) async {
    emit(GetOneTaskLoading());
    final result = await logoRepo.getOneTask(userId: userId);
    result.fold(
            (failure) => emit(GetOneTaskFailure(errorMessage: failure.message)),
            (logo) =>
            emit(GetOneTaskSuccess(logoEntity: logo))
    );
  }
}
