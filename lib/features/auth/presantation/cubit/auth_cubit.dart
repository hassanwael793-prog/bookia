import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../data/rebo/auth_rebo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(loginLoadingState());
    try {
      final isSuccess = await authRepo.login(email: email, password: password);
      if (isSuccess) {
        emit(loginSuccessState());
      } else {
        emit(loginErrorState("فشل تسجيل الدخول، تأكد من البيانات."));
      }
    }  catch (e) {
      return null;
    }
  }
}