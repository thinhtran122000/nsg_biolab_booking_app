part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class NavigateScreenEvent extends NavigationEvent {
  final int indexPage;
  NavigateScreenEvent({
    required this.indexPage,
  });
}