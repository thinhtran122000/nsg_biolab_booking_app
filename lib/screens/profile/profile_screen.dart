import 'package:codebase/screens/profile/widget/bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../component/index.dart';
import '../../utilities/rest_api_client/api_client.dart';
import '../../utilities/shared_preferences/shared_preferences.dart';
import '../../utilities/validation/validate.dart';
import '../change_password/change_password_screen.dart';
import '../login/login_screen.dart';
import 'bloc/profile_bloc.dart';
import 'profile_repository.dart';
import 'widget/text_profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) =>
            ProfileBloc(ProfileReponstory(RestAPIClient()))..add(FetchDataProfileEvent()),
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ChangeProfileSuccess) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop();
                showDialogEdit(
                  context: context,
                  message: 'Your profile has been updated!',
                );
              });
            }
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<ProfileBloc>(context);
            return Scaffold(
              appBar: CustomAppBar(
                titleAppBar: 'Profile',
                visibleAction: true,
                onPressAction: () => showDialogLogOut(context),
                iconAction: Icon(
                  Icons.exit_to_app,
                  color: blackColor,
                ),
              ),
              backgroundColor: whiteColor,
              body: Stack(
                children: [
                  const BackGroundWidget(
                    visibleTitle: false,
                    visibilityBackGround: true,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 19,
                        ),
                        CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 60,
                          backgroundImage: bloc.fileImage != null
                              ? Image.file(
                                  bloc.fileImage!,
                                  scale: 1,
                                ).image
                              : bloc.avatar == null
                                  ? Image.network(
                                      ImagePath.noImage.assetName,
                                      fit: BoxFit.cover,
                                      scale: 1,
                                    ).image
                                  : Image.network(
                                      bloc.avatar!,
                                      fit: BoxFit.cover,
                                      scale: 1,
                                    ).image,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () => openBottomSheetMenu(context),
                            child: Text(
                              'Edit Photo',
                              style: largeGreenBlurTextStyle,
                            ),
                          ),
                        ),
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextProfileWidget(
                                  label: 'Name',
                                  textStyle: largeBlackBlurTextStyle,
                                ),
                                const SizedBox(height: 7),
                                TextFormFieldWidget(
                                  isReadOnly: false,
                                  textCotroller: bloc.nameController,
                                  hintLabel: 'Name',
                                  iconPassword: false,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextProfileWidget(
                                  label: 'Email',
                                  textStyle: largeBlackBlurTextStyle,
                                ),
                                const SizedBox(height: 7),
                                TextFormFieldWidget(
                                  isReadOnly: true,
                                  textCotroller: bloc.emailController,
                                  hintLabel: 'Email',
                                  iconPassword: false,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextProfileWidget(
                                  label: 'Company',
                                  textStyle: largeBlackBlurTextStyle,
                                ),
                                const SizedBox(height: 7),
                                TextFormFieldWidget(
                                  isReadOnly: true,
                                  hintLabel: 'Company',
                                  iconPassword: false,
                                  textCotroller: bloc.companyController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextProfileWidget(
                                  label: 'Role',
                                  textStyle: largeBlackBlurTextStyle,
                                ),
                                const SizedBox(height: 7),
                                TextFormFieldWidget(
                                  textCotroller: bloc.roleController,
                                  hintLabel: 'Role',
                                  iconPassword: false,
                                  isReadOnly: false,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextProfileWidget(
                                  label: 'Phone Number',
                                  textStyle: largeBlackBlurTextStyle,
                                ),
                                const SizedBox(height: 7),
                                TextFormFieldWidget(
                                  textCotroller: bloc.phoneController,
                                  isReadOnly: false,
                                  hintLabel: 'Phone Number',
                                  iconPassword: false,
                                ),
                                const SizedBox(height: 20),
                                SaveButton(
                                  onPressed: () {
                                    showProgressIndicatorEditing(context);
                                    editProfile(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 23, 0, 20),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              HorizontalNavigatorRoute(
                                begin: const Offset(1, 0),
                                page: const ChangePasswordScreen(),
                              ),
                            ),
                            child: Text(
                              'Change Password',
                              style: largeGreenBlurTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 75),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  editProfile(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    if (bloc.nameController.text.trim() == '') {
      showDialogEdit(
        context: context,
        message: validateName(bloc.nameController.text.trim()),
      );
    } else {
      bloc.add(
        ChangeProfile(
          name: bloc.nameController.text,
          role: bloc.roleController.text,
          phoneNumber: bloc.phoneController.text,
        ),
      );
    }
  }

  logOut(BuildContext context) {
    clearToken();
    Future.delayed(
      const Duration(milliseconds: 500),
      () => Navigator.of(context).pushAndRemoveUntil(
        VerticalNavigatorRoute(
          begin: const Offset(0, -1),
          page: const LoginScreen(),
        ),
        (route) => false,
      ),
    );
  }

  showDialogLogOut(BuildContext context) => showDialog(
        context: context,
        builder: (dialogContext) {
          return CustomDialog(
            visibleBackButton: true,
            visibleConfirmButton: true,
            visibleDialogTitle: true,
            visibleMessage: false,
            askingString: 'Logout?',
            labelBackButton: 'Back',
            labelConfirmButton: 'LOGOUT',
            colorConfirmButton: redColor,
            onTapBackButton: () => Navigator.pop(dialogContext),
            onTapConfirmButton: () {
              Navigator.pop(dialogContext);
              showProgressIndicatorLogout(context);
              logOut(context);
            },
          );
        },
      );

  showDialogEdit({
    required BuildContext context,
    String? message,
  }) =>
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            visibleBackButton: false,
            visibleConfirmButton: true,
            visibleDialogTitle: false,
            visibleMessage: true,
            message: 'Your profile has been updated!',
            labelConfirmButton: 'OK',
            colorConfirmButton: greenColor,
            onTapConfirmButton: () => Navigator.pop(context),
          );
        },
      );

  showProgressIndicatorEditing(BuildContext context) => showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 30,
              color: greenColor,
            ),
          );
        },
      );

  showProgressIndicatorLogout(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => Center(
        child: CupertinoActivityIndicator(
          radius: 30,
          color: greenColor,
        ),
      ),
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () => Navigator.of(context).pop(),
    );
  }

  openBottomSheetMenu(BuildContext context) {
    var bloc = context.read<ProfileBloc>();
    showCupertinoModalPopup(
      barrierColor: const Color.fromARGB(149, 18, 18, 18),
      context: context,
      builder: (builder) => BottomSheetWidget(
        onTapCamera: () {
          bloc.add(ChangeImage(0));
          Navigator.pop(context);
        },
        onTapGallery: () {
          bloc.add(ChangeImage(1));
          Navigator.pop(context);
        },
      ),
    );
  }
}
