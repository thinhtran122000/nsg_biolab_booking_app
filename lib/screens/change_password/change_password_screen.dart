import 'package:codebase/screens/change_password/change_password_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/rest_api_client/api_client.dart';
import '../login/widgets/index.dart';
import 'bloc/change_password_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(ChangePasswordRepository(RestAPIClient())),
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordNotify) {
            showDialogNotify(
              context: context,
              message: state.errorMessage,
              onTapConfirmButton: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          } else if (state is ChangePasswordSuccess) {
            showDialogNotify(
              context: context,
              message: state.message,
              onTapConfirmButton: () {
                Navigator.pop(context);
                showProgressIndicatorPopScreen(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<ChangePasswordBloc>(context);
          return Scaffold(
            appBar: CustomAppBar(
              titleAppBar: 'Change Password',
              visibleLeading: true,
              onPressLeading: () => Navigator.of(context).pop(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    const TextWidget(label: 'Current password'),
                    const SizedBox(height: 7),
                    TextFormFieldWidget(
                      isReadOnly: false,
                      hintLabel: 'Current Password',
                      iconPassword: true,
                      textCotroller: bloc.currentPasswordCotroller,
                    ),
                    const SizedBox(height: 20),
                    const TextWidget(label: 'New password'),
                    const SizedBox(height: 7),
                    TextFormFieldWidget(
                      isReadOnly: false,
                      hintLabel: 'New Password',
                      iconPassword: true,
                      textCotroller: bloc.newPasswordCotroller,
                    ),
                    const SizedBox(height: 20),
                    const TextWidget(label: 'Confirm New password'),
                    const SizedBox(height: 7),
                    TextFormFieldWidget(
                      isReadOnly: false,
                      hintLabel: 'Confirm New Password',
                      iconPassword: true,
                      textCotroller: bloc.confirmPasswordCotroller,
                    ),
                    const SizedBox(height: 20),
                    ChangePasswordButton(
                      onPressed: () {
                        showProgressIndicatorChanging(context);
                        onChangePassword(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  onChangePassword(BuildContext context) {
    final bloc = BlocProvider.of<ChangePasswordBloc>(context);
    bloc.add(
      ChangePassword(
        currentPassword: bloc.currentPasswordCotroller.text.trim(),
        newPassword: bloc.newPasswordCotroller.text.trim(),
        newPasswordConfirmation: bloc.confirmPasswordCotroller.text.trim(),
      ),
    );
  }

  showProgressIndicatorPopScreen(BuildContext context) {
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
      const Duration(seconds: 1),
      () => Navigator.of(context).pop(),
    );
  }

  showProgressIndicatorChanging(BuildContext context) {
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
  }

  showDialogNotify(
      {required BuildContext context, String? message, void Function()? onTapConfirmButton}) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            visibleBackButton: false,
            visibleConfirmButton: true,
            visibleDialogTitle: false,
            visibleMessage: true,
            colorConfirmButton: greenColor,
            message: message, 
            labelConfirmButton: 'OK',
            onTapConfirmButton: onTapConfirmButton,
          ),
        );
      },
    );
  }
}
