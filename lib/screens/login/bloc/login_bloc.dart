import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nsg_biolab_booking_app/utilities/validation/validate.dart';

import '../../../utilities/shared_preferences/shared_preferences.dart';
import '../login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }
  LoginRepository loginRepository;

  TextEditingController emailCotroller = TextEditingController();
  TextEditingController passwordCotroller = TextEditingController();

  _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    if (validateEmail(event.email).isNotEmpty) {
      await Future.delayed(
        const Duration(milliseconds: 500),
        () => emit(LoginError(validateEmail(event.email))),
      );
    } else if (validatePassword(event.password).isNotEmpty) {
      await Future.delayed(
        const Duration(milliseconds: 500),
        () => emit(LoginError(validatePassword(event.password))),
      );
    } else {
      try {
        final response = await loginRepository.loginWithEmail(email: event.email, password: event.password);
        await setToken(response.object.token ?? '');
        await settokenExpired(response.object.tokenExpiredAt ?? '');
        await Future.delayed(
          const Duration(milliseconds: 500),
          () => emit(LoginSuccess()),
        );
      } catch (e) {
        await Future.delayed(
          const Duration(milliseconds: 500),
          () => emit(LoginError(e.toString())),
        );
      }
    }
  }
}
