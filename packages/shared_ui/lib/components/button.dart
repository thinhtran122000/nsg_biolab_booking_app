import 'package:flutter/material.dart';

import '../shared_ui.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Login',
        style: largeWhiteTextStyle,
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Submit',
        style: largeWhiteTextStyle,
      ),
    );
  }
}

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Back To Login',
        style: largeWhiteTextStyle,
      ),
    );
  }
}

class BackToLoginTextButton extends StatelessWidget {
  const BackToLoginTextButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        'Back To Login',
        style: largeGreenTextStyle,
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Save',
        style: largeWhiteTextStyle,
      ),
    );
  }
}

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Change Password',
        style: largeWhiteTextStyle,
      ),
    );
  }
}

class ForgotPasswordTextButton extends StatelessWidget {
  const ForgotPasswordTextButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        'Forgot Password?',
        style: largeGreenTextStyle,
      ),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    this.onPress,
    this.style,
  }) : super(key: key);
  final void Function()? onPress;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: style,
      child: Text(
        'Confirm',
        style: largeWhiteTextStyle,
      ),
    );
  }
}

class CancelBookingButton extends StatelessWidget {
  const CancelBookingButton({required this.onPress, super.key, this.textCancel});
  final String? textCancel;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: redButtonStyle,
      child: Text(
        textCancel ?? '',
        style: largeWhiteTextStyle,
      ),
    );
  }
}

class BackToHomeTextButton extends StatelessWidget {
  const BackToHomeTextButton({required this.onPress, super.key});
  final void Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: greenButtonStyle,
      child: Text(
        'Back to Home',
        style: largeWhiteTextStyle,
      ),
    );
  }
}
