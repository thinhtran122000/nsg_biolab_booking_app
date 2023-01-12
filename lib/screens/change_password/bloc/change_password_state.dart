part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String? message;
  ChangePasswordSuccess({this.message});
}

class ChangePasswordNotify extends ChangePasswordState {
  final String? errorMessage;
  ChangePasswordNotify({this.errorMessage});
}
