import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../component/index.dart';
import '../../utilities/rest_api_client/api_client.dart';
import '../forgot_password_submit/forgot_password_submit_screen.dart';
import 'bloc/forgot_password_bloc.dart';
import 'index.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(ForgotPasswordRepository(RestAPIClient())),
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            Navigator.of(context).pop();
            openForgotPasswordSubmit(context);
          } else if (state is ForgotPasswordError) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<ForgotPasswordBloc>(context);
          return Scaffold(
            backgroundColor: whiteColor,
            body: Stack(
              children: [
                const BackGroundWidget(
                  visibilityBackGround: true,
                  visibleTitle: false,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 130,
                      ),
                      const PrimaryImage(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'Forgot Password',
                          style: largeBlackBlurTextStyle,
                        ),
                      ),
                      BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                        builder: (context, state) {
                          if (state is ForgotPasswordError) {
                            return ErrorMessage(
                              message: state.messageError.toString(),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Email',
                                style: largeBlackBlurTextStyle,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              TextFormFieldWidget(
                                isReadOnly: false,
                                textCotroller: bloc.emailCotroller,
                                hintLabel: 'Email',
                                iconPassword: false,
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              SubmitButton(
                                onPressed: () {
                                  showProgressIndicator(context);
                                  onForgotPassword(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0),
                        child: BackToLoginTextButton(
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  openForgotPasswordSubmit(BuildContext context) => Navigator.push(
        context,
        HorizontalNavigatorRoute(
          begin: const Offset(1, 0),
          page: const ForgotPasswordSubmitScreen(),
        ),
      );

  onForgotPassword(BuildContext context) {
    final bloc = BlocProvider.of<ForgotPasswordBloc>(context);
    bloc.add(
      ForgotPasswordRequest(
        email: bloc.emailCotroller.text.trim(),
      ),
    );
  }

  showProgressIndicator(BuildContext context) => showDialog(
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
}
