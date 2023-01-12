import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../component/index.dart';
import '../../utilities/rest_api_client/api_client.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../navigation/navigation_screen.dart';
import 'bloc/login_bloc.dart';
import 'login_repository.dart';
import 'widgets/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(LoginRepository(RestAPIClient())),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pop();
            Navigator.pushAndRemoveUntil(
              context,
              VerticalNavigatorRoute(
                begin: const Offset(1, 0),
                page: const NavigationScreen(),
              ),
              (route) => false,
            );
          } else if (state is LoginError) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<LoginBloc>(context);
          return Scaffold(
            backgroundColor: whiteColor,
            body: Stack(
              children: [
                const BackGroundWidget(
                  visibleTitle: false,
                  visibilityBackGround: true,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 130,
                      ),
                      const PrimaryImage(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: TextWidget(
                          label: 'Login',
                        ),
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginError) {
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
                              const TextWidget(
                                label: 'Email',
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              TextFormFieldWidget(
                                isReadOnly: false,
                                hintLabel: 'Email',
                                iconPassword: false,
                                textCotroller: bloc.emailCotroller,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const TextWidget(
                                label: 'Password',
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              TextFormFieldWidget(
                                isReadOnly: false,
                                textCotroller: bloc.passwordCotroller,
                                hintLabel: 'Password',
                                iconPassword: true,
                              ),
                              const SizedBox(height: 28),
                              LoginButton(
                                onPressed: () {
                                  showProgressIndicator(context);
                                  bloc.add(
                                    LoginRequested(
                                      email: bloc.emailCotroller.text.trim(),
                                      password: bloc.passwordCotroller.text.trim(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 28, 0, 50),
                        child: ForgotPasswordTextButton(
                          onPressed: () => Navigator.push(
                            context,
                            HorizontalNavigatorRoute(
                              begin: const Offset(1, 0),
                              page: const ForgotPasswordScreen(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
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
