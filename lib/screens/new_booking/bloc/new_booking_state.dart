part of 'new_booking_bloc.dart';

abstract class NewBookingState {
  final bool? visibleFilterIcon;
  final int indexView;
  final FilterModel? resultFilter;
  NewBookingState({
    this.visibleFilterIcon,
    required this.indexView,
    this.resultFilter,
  });
}

class NewBookingInitial extends NewBookingState {
  NewBookingInitial({
    required super.visibleFilterIcon,
    required super.indexView,
    super.resultFilter,
  });
}
