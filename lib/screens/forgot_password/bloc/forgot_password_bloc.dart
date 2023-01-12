import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../utilities/validation/validate.dart';
import '../index.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(this.forgotPasswordRepository) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordRequest>(_onForgotPasswordRequest);
  }

  ForgotPasswordRepository forgotPasswordRepository;
  TextEditingController emailCotroller = TextEditingController();

  _onForgotPasswordRequest(ForgotPasswordRequest event, Emitter<ForgotPasswordState> emit) async {
    if (validateEmail(event.email).isNotEmpty) {
      await Future.delayed(
        const Duration(milliseconds: 500),
        () => emit(ForgotPasswordError(validateEmail(event.email))),
      );
    } else {
      try {
        forgotPasswordRepository.forgotPassword(email: event.email);
        await Future.delayed(
          const Duration(milliseconds: 500),
          () => emit(ForgotPasswordSuccess()),
        );
      } catch (e) {
        await Future.delayed(
          const Duration(milliseconds: 500),
          () => emit(ForgotPasswordError(e.toString())),
        );
      }
    }
  }
}
