import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class SuccessBookingScreen extends StatelessWidget {
  const SuccessBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_sharp,
                color: greenColor,
                size: 65,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Booking Success',
                style: superLargeBlackHeavyFuturaTextStyle,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Your booking has been confirmed',
                style: mediumBlackBlurTextStyle,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 369,
                height: 48,
                child: BackToHomeTextButton(
                  onPress: () => Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
