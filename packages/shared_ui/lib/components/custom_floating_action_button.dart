import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget iconButton;
  final Color? backgroundColor;
  final String heroTagButton;

  const CustomFloatingActionButton({
    Key? key,
    this.onPressed,
    required this.iconButton,
    this.backgroundColor,
    required this.heroTagButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 64),
      child: SizedBox(
        width: 58,
        height: 58,
        child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
          ),
          child: FloatingActionButton(
            heroTag: heroTagButton,
            splashColor: Colors.transparent,
            onPressed: onPressed,
            backgroundColor: backgroundColor,
            child: iconButton,
          ),
        ),
      ),
    );
  }
}
