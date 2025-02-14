import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repos/user_repository.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.repository) : super(SigninInitial());
  final UserRepository repository;


  Future<void> signIn({required String phone, required String password}) async {
    emit(SigninLoading());

    final result = await repository.signIn(phone: phone, password: password);

    result.fold(
          (failure) => emit(SigninFailure("the phone number or password is wrong")),

          (users) => emit(SigninSuccess()),
    );
  }
}
