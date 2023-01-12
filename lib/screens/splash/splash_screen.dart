import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/shared_preferences/shared_preferences.dart';
import '../login/login_screen.dart';
import '../navigation/navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    countDownTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        ImagePath.splashScreen.assetName,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  countDownTime() async => Timer(
        const Duration(seconds: 1),
        () async {
          if (await getToken() != null) {
            Navigator.pushAndRemoveUntil(
                context,
                VerticalNavigatorRoute(
                  page: const NavigationScreen(),
                  begin: const Offset(0, 1),
                ),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              VerticalNavigatorRoute(
                page: const LoginScreen(),
                begin: const Offset(0, -1),
              ),
              (route) => false,
            );
          }
        },
      );
}
