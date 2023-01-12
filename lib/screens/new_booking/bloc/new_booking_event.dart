part of 'new_booking_bloc.dart';

abstract class NewBookingEvent {}

class ChangeTabEvent extends NewBookingEvent {
  final int indexView;
  ChangeTabEvent({
    required this.indexView,
  });
}

class SetDataFilter extends NewBookingEvent {
  final FilterModel? resultsFilter;
  SetDataFilter({
    this.resultsFilter,
  });
}
