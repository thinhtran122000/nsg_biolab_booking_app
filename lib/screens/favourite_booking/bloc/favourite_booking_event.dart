part of 'favourite_booking_bloc.dart';

abstract class FavouriteBookingEvent {}

class ChangeTabEvent extends FavouriteBookingEvent {
  final int indexView;
  ChangeTabEvent({
    required this.indexView,
  });
}
