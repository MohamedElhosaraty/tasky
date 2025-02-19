import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/auth/domain/repos/user_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.userRepository) : super(SignupInitial());

  final UserRepository userRepository;

  Future<void> signUp({
    required String phone,
    required String password,
    required String displayName,
    required int experienceYears,
    required String address,
    required String level,
  }) async {
    emit(SignupLoading());
    final result = await userRepository.signUp(
        phone: phone,
        password: password,
        displayName: displayName,
        experienceYears: experienceYears,
        address: address,
        level: level);
    result.fold(
      (failure) => emit(SignupFailure(errorMessage: failure.toString())),
      (users) => emit(SignupSuccess()),
    );
  }
}
