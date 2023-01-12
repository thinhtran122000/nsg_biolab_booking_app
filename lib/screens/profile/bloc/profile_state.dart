part of 'profile_bloc.dart';


abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ChangeProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String errorMessage;
  ProfileError({
    required this.errorMessage,
  });
}
