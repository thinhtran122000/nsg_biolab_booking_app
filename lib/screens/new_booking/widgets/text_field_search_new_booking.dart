import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class TextFieldSearchNewBooking extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  const TextFieldSearchNewBooking({super.key, this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 23, 24, 14),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: greyColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
          hintText: 'Search',
          hintStyle: largeGreyTextStyle,
          suffixIcon: Icon(
            Icons.search,
            color: greyColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: lightGreyColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: lightGreyColor,
            ),
          ),
        ),
      ),
    );
  }
}
