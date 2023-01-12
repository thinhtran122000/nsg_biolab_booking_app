import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import '../screens/new_booking/widgets/index.dart';

class ItemEquipmentWidget extends StatelessWidget {
  final VoidCallback? onTapItem;
  final String nameEquipmentData;
  final String levelAndSiteNameEquipmentData;
  final VoidCallback? onTapLike;
  final VoidCallback? onTapInfo;
  final IconData? iconLike;
  final Color colorTagEquipment;

  const ItemEquipmentWidget({
    Key? key,
    this.onTapItem,
    required this.nameEquipmentData,
    required this.levelAndSiteNameEquipmentData,
    this.onTapLike,
    this.onTapInfo,
    this.iconLike,
    required this.colorTagEquipment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        padding: const EdgeInsets.fromLTRB(17, 5, 20, 0),
        width: 366,
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 5,
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            width: 1,
            color: lightGreyColor,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: TextWidgetItemNewBooking(
                    data: nameEquipmentData,
                    textStyle: superLargeBlackHeavyFuturaTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: GestureDetector(
                    onTap: onTapLike,
                    child: Icon(
                      iconLike,
                      color: greenColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 9),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: colorTagEquipment, width: 8),
                      ),
                    ),
                    width: 265,
                    child: TextWidgetItemNewBooking(
                      data: levelAndSiteNameEquipmentData,
                      textStyle: largeBlackSuperBlurTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: onTapInfo,
                    child: ImageIcon(
                      AssetImage(
                        ImagePath.infoIcon.assetName,
                      ),
                      color: greenColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
