import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class AlertIcon extends StatelessWidget {
  const AlertIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagePath.alertIcon.assetName,
      isAntiAlias: true,
      filterQuality: FilterQuality.high,
      width: 24,
      height: 24,
      scale: 2,
    );
  }
}
