import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String data;
  final TextStyle? textStyle;
  const CustomTab({
    super.key,
    required this.data,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      alignment: Alignment.center,
      child: Text(
        data,
        style: textStyle,
        softWrap: true,
      ),
    );
  }
}
