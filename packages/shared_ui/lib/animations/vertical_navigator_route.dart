import 'package:flutter/material.dart';

class VerticalNavigatorRoute extends PageRouteBuilder {
  final Widget page;
  final Offset begin;
  VerticalNavigatorRoute({
    required this.page,
    required this.begin,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
            position: Tween<Offset>(
              begin: begin,
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}
