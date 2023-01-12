import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileReponstory profileReponstory;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? avatar;
  File? fileImage;
  ProfileBloc(this.profileReponstory) : super(ProfileSuccess()) {
    on<FetchDataProfileEvent>(_onFetchDataProfileEvent);
    on<ChangeImage>(_onChangeImage);
    on<ChangeProfile>(_onChangeProfile);
  }

  FutureOr<void> _onFetchDataProfileEvent(
      FetchDataProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      final response = await profileReponstory.getProfile();
      nameController.text = response.object.fullName ?? '';
      emailController.text = response.object.email ?? '';
      companyController.text = response.object.company?.name ?? '';
      roleController.text = response.object.role ?? '';
      phoneController.text = response.object.phoneNumber ?? '';
      avatar = response.object.avatar;
      log('---$avatar');
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onChangeImage(ChangeImage event, Emitter<ProfileState> emit) async {
    try {
      if (event.choice == 0) {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image == null) return;
        fileImage = File(image.path);
      } else {
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        fileImage = File(image.path);
      }
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onChangeProfile(ChangeProfile event, Emitter<ProfileState> emit) async {
    try {
      final response =
          await profileReponstory.changeProfile(event.name, event.role, event.phoneNumber ?? '');
      avatar = response.object.avatar ?? '';
      nameController = TextEditingController(text: response.object.fullName);
      roleController = TextEditingController(text: response.object.role);
      phoneController = TextEditingController(text: response.object.phoneNumber);
      emit(ChangeProfileSuccess());
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }
}
