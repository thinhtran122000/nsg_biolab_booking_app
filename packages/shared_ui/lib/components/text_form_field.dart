// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    required this.textCotroller,
    required this.hintLabel,
    super.key,
    required this.iconPassword,
    required this.isReadOnly,
  });
  final TextEditingController textCotroller;
  final String hintLabel;
  final bool isReadOnly;
  final bool iconPassword;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isCheckPass = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: largeBlackBlurTextStyle,
      cursorColor: greyColor,
      readOnly: widget.isReadOnly,
      controller: widget.textCotroller,
      obscureText: widget.iconPassword ? isCheckPass : false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 18,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            color: Colors.red,
            width: 10,
          ),
        ),
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder,
        filled: true,
        hintStyle: largeGreyTextStyle,
        suffixIcon: widget.iconPassword
            ? IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () => setState(
                  () => isCheckPass = !isCheckPass,
                ),
                icon: isCheckPass
                    ? Image.asset(
                        ImagePath.eyePassClose.assetName,
                        height: 20,
                        width: 20,
                      )
                    : Icon(
                        Icons.remove_red_eye_sharp,
                        size: 20,
                        color: greenColor,
                      ),
              )
            : null,
        hintText: widget.hintLabel,
        fillColor: widget.isReadOnly ? superLightGreyColor : whiteColor,
      ),
    );
  }
}

OutlineInputBorder get outlineBorder => OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        color: lightGreyColor,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );
