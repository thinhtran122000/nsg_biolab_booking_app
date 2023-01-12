import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import '../screens/home_booking/widgets/index.dart';

class BackGroundWidget extends StatelessWidget {
  final String? notificationData;
  final String? startMessageRequiredData;
  final String? endMessageRequiredData;
  final bool visibilityBackGround;
  final bool visibleTitle;
  const BackGroundWidget({
    Key? key,
    this.notificationData,
    this.startMessageRequiredData,
    this.endMessageRequiredData,
    required this.visibilityBackGround,
    required this.visibleTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibilityBackGround,
      child: Stack(
        children: [
          Positioned(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Image.asset(
                    ImagePath.polygon4.assetName,
                    fit: BoxFit.fill,
                    width: 240,
                    height: 100,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Image.asset(
                    ImagePath.polygon3.assetName,
                    fit: BoxFit.fill,
                    width: 200,
                    height: 140,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidgetItemHome(
                    data: notificationData ?? '',
                    textStyle: superLargeBlackHeavyFuturaTextStyle,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: visibleTitle,
                    child: Text.rich(
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
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: greenColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add_sharp,
                                    size: 20,
                                    color: whiteColor,
                                  ),
                                ),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
