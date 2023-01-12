import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import 'index.dart';

class ItemBookingWidget extends StatelessWidget {
  final VoidCallback? onTapItem;
  final Color colorTagBooking;
  final String orderableNameData;
  final String levelAndSiteNameData;
  final String dateBookingData;
  final String timeBookingData;
  const ItemBookingWidget({
    Key? key,
    this.onTapItem,
    required this.colorTagBooking,
    required this.orderableNameData,
    required this.levelAndSiteNameData,
    required this.dateBookingData,
    required this.timeBookingData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        // width: 366,
        padding: const EdgeInsets.fromLTRB(8.5, 0, 1, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.025, 0.01],
            colors: [
              colorTagBooking,
              lightGreyColor,
            ],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 5,
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 15, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidgetItemHome(
                  data: orderableNameData,
                  textStyle: superLargeBlackHeavyFuturaTextStyle,
                ),
                const SizedBox(height: 20),
                TextWidgetItemHome(
                  data: levelAndSiteNameData,
                  textStyle: largeGreyTextStyle,
                ),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$dateBookingData\n',
                        style: mediumBlackTextStyle,
                      ),
                      TextSpan(
                        text: timeBookingData,
                        style: smallBlackBlurTextStyle,
                      ),
                    ],
                  ),
                  softWrap: true,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
