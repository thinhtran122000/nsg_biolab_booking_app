import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import 'index.dart';

class BackgroundEmptyDataFavourite extends StatelessWidget {
  final String notificationData;
  final String startMessageRequiredData;
  final String endMessageRequiredData;
  final bool visibility;
  const BackgroundEmptyDataFavourite({
    super.key,
    required this.notificationData,
    required this.startMessageRequiredData,
    required this.endMessageRequiredData,
    required this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidgetItemFavourite(
              data: notificationData,
              textStyle: superLargeBlackHeavyFuturaTextStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: startMessageRequiredData,
                    style: mediumBlackBlurTextStyle,
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.favorite,
                        size: 20,
                        color: greenColor,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: endMessageRequiredData,
                    style: mediumBlackBlurTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
