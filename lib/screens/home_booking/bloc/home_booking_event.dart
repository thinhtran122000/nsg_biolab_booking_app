part of 'home_booking_bloc.dart';

abstract class HomeBookingEvent {}

class FetchDataHomeBookingEvent extends HomeBookingEvent {}

class LoadMoreUpcomingBookingEvent extends HomeBookingEvent {}

class ShowButtonScrollTopEvent extends HomeBookingEvent {
  final List<UpcomingBooking> listUpcomingBooking;
  final List<OngoingBooking> listOngoingBooking;
  ShowButtonScrollTopEvent({
    required this.listUpcomingBooking,
    required this.listOngoingBooking,
  });
}

class ScrollTopEvent extends HomeBookingEvent {
  final List<UpcomingBooking> listUpcomingBooking;
  final List<OngoingBooking> listOngoingBooking;
  ScrollTopEvent({
    required this.listUpcomingBooking,
    required this.listOngoingBooking,
  });
}