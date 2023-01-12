import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class TextWidgetTitleListAndResetButton extends StatelessWidget {
  final String dataTitleListFilter;
  final String dataTextButton;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTapResetButton;
  const TextWidgetTitleListAndResetButton(
      {super.key,
      this.onTapResetButton,
      required this.dataTitleListFilter,
      required this.dataTextButton,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dataTitleListFilter,
            style: superLargeBlackBlurMediumFuturaTextStyle,
          ),
          GestureDetector(
            onTap: onTapResetButton,
            child: Text(
              dataTextButton,
              style: superLargeGreenMediumTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
