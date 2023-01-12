part of 'navigation_bloc.dart';

abstract class NavigationState {
  final List<StatelessWidget> listPage;

  NavigationState({
    required this.listPage,
  });
}

class NavigationInitial extends NavigationState {
  NavigationInitial({required super.listPage});
}
