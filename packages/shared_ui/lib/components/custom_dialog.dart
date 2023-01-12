import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback? onTapBackButton;
  final VoidCallback? onTapConfirmButton;
  final bool? visibleBackButton;
  final bool? visibleConfirmButton;
  final bool? visibleDialogTitle;
  final bool? visibleMessage;
  final String? labelBackButton;
  final String? labelConfirmButton;
  final String? message;
  final String? askingString;
  final String? undoString;
  final double? height;
  final Color? colorConfirmButton;
  const CustomDialog({
    super.key,
    this.height,
    this.onTapBackButton,
    this.onTapConfirmButton,
    this.labelBackButton,
    this.labelConfirmButton,
    this.message,
    this.colorConfirmButton,
    this.askingString,
    this.undoString,
    required this.visibleBackButton,
    required this.visibleConfirmButton,
    required this.visibleDialogTitle,
    required this.visibleMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 39, 28, 33),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Visibility(
                      visible: visibleDialogTitle ?? false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            textAlign: TextAlign.left,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: askingString,
                                  style: superLargeBlackMediumFuturaTextStyle,
                                ),
                                TextSpan(
                                  text: undoString,
                                  style: superLargeGreyMediumFuturaTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: visibleMessage ?? false,
                      child: Text(
                        message ?? '',
                        maxLines: 10,
                        style: superLargeBlackMediumFuturaTextStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: visibleBackButton ?? false,
                        child: GestureDetector(
                          onTap: onTapBackButton,
                          child: Text(
                            labelBackButton ?? '',
                            style: smallBlackTextStyle,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: visibleConfirmButton ?? false,
                        child: GestureDetector(
                          onTap: onTapConfirmButton,
                          child: Text(
                            labelConfirmButton ?? '',
                            style: TextStyle(
                              package: 'shared_ui',
                              fontFamily: FontsPath.futuraMediumBT.assetName,
                              fontSize: 14,
                              color: colorConfirmButton,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
