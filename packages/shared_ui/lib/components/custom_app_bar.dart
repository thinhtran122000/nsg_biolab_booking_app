import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleAppBar;
  final bool? visibleAction;
  final bool? visibleLeading;
  final Widget? iconAction;
  final VoidCallback? onPressLeading;
  final VoidCallback? onPressAction;

  const CustomAppBar({
    Key? key,
    required this.titleAppBar,
    this.visibleAction,
    this.visibleLeading,
    this.iconAction,
    this.onPressLeading,
    this.onPressAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Visibility(
        visible: visibleLeading ?? false,
        child: GestureDetector(
          onTap: onPressLeading,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      actions: [
        Visibility(
          visible: visibleAction ?? false,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: onPressAction,
            icon: iconAction ?? const SizedBox(),
          ),
        ),
      ],
      backgroundColor: whiteColor,
      elevation: 1,
      centerTitle: true,
      title: Text(
        titleAppBar,
        style: superLargeBlackHeavyFuturaTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
