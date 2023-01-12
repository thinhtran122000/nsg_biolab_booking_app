import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../component/index.dart';
import '../login/login_screen.dart';

class ForgotPasswordSubmitScreen extends StatelessWidget {
  const ForgotPasswordSubmitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(
            visibleTitle: false,
            visibilityBackGround: true,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: greenColor,
                size: 65.0,
              ),
              const SizedBox(height: 24),
              Text(
                'Submitted',
                style: superLargeBlackHeavyFuturaTextStyle,
              ),
              const SizedBox(height: 8),
              Text(
                'Check your email for further instructions',
                style: largeBlackBlurTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: 369,
                  height: 48,
                  child: BackToLoginButton(
                    onPressed: () => backToLogin(context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  backToLogin(BuildContext context) => Navigator.pushReplacement(
        context,
        HorizontalNavigatorRoute(begin: const Offset(1, 0), page: const LoginScreen()),
      );
}
