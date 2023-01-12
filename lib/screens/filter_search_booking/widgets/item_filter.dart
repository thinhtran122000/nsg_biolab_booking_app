import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class ItemFilter extends StatelessWidget {
  final VoidCallback? onCheck;
  final String dataFilter;
  final bool? isChecked;
  const ItemFilter({
    super.key,
    this.onCheck,
    required this.dataFilter,
    this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCheck,
      child: Container(
        width: 364,
        height: 58,
        color: superLightGreyColor,
        padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                dataFilter,
                style: largeBlackBlurTextStyle,
              ),
            ),
            Stack(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9DBE9),
                    shape: BoxShape.circle,
                  ),
                ),
                Visibility(
                  visible: isChecked ?? false,
                  child: Container(
                    alignment: Alignment.center,
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: greenColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: whiteColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
