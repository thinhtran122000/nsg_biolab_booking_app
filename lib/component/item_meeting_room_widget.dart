import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import '../screens/new_booking/widgets/index.dart';

class ItemMeetingRoomWidget extends StatelessWidget {
  final VoidCallback? onTapItem;
  final VoidCallback? onTapLike;
  final IconData? iconLike;
  final Color colorTagMeetingRoom;
  final String levelAndSiteNameMeetingRoomData;
  final String nameMeetingRoomData;

  const ItemMeetingRoomWidget({
    Key? key,
    this.onTapItem,
    this.onTapLike,
    this.iconLike,
    required this.colorTagMeetingRoom,
    required this.levelAndSiteNameMeetingRoomData,
    required this.nameMeetingRoomData,
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
                    data: nameMeetingRoomData,
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
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: 265,
                    padding: const EdgeInsets.only(left: 9),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: colorTagMeetingRoom,
                          width: 8,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextWidgetItemNewBooking(
                        data: levelAndSiteNameMeetingRoomData,
                        textStyle: largeBlackSuperBlurTextStyle,
                      ),
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
