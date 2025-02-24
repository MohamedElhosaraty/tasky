part of 'logo_cubit.dart';

sealed class LogoState {}

final class LogoInitial extends LogoState {}

final class LogoLoading extends LogoState {}

final class LogoSuccess extends LogoState {
  final List<LogoEntity> logoEntity;
  final String source;
  final String? errorMessage;

  LogoSuccess({
    required this.logoEntity,
    required this.source,
    this.errorMessage,
  });
}

final class LogoFailure extends LogoState {
  final String errorMessage;

  LogoFailure({required this.errorMessage});
}

final class GetOneTaskLoading extends LogoState {}

final class GetOneTaskSuccess extends LogoState {
   final LogoEntity logoEntity;

  GetOneTaskSuccess({required this.logoEntity});
}

final class GetOneTaskFailure extends LogoState {
  final String errorMessage;

  GetOneTaskFailure({required this.errorMessage});
}

final class EditTaskLoading extends LogoState {}

final class EditTaskSuccess extends LogoState {}

final class EditTaskFailure extends LogoState {
  final String errorMessage;

  EditTaskFailure({required this.errorMessage});
}

final class DeleteTaskLoading extends LogoState {}

final class DeleteTaskSuccess extends LogoState {}

final class DeleteTaskFailure extends LogoState {
  final String errorMessage;

  DeleteTaskFailure({required this.errorMessage});
}

final class LogoutLoading extends LogoState {}

final class LogoutSuccess extends LogoState {}

final class LogoutFailure extends LogoState {
  final String errorMessage;

  LogoutFailure({required this.errorMessage});
}
