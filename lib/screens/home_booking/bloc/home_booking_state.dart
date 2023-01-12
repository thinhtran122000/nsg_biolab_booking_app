part of 'home_booking_bloc.dart';

abstract class HomeBookingState {
  final List<UpcomingBooking> listUpcomingBooking;
  final List<OngoingBooking> listOngoingBooking;
  HomeBookingState({
    required this.listUpcomingBooking,
    required this.listOngoingBooking,
  });
}

class HomeBookingInitial extends HomeBookingState {
  HomeBookingInitial({
    required super.listUpcomingBooking,
    required super.listOngoingBooking,
  });
}

class HomeBookingSucess extends HomeBookingState {
  // final List<UpcomingBooking> listUpcomingBooking;
  // final List<OngoingBooking> listOngoingBooking;
  HomeBookingSucess({
    required super.listOngoingBooking,
    required super.listUpcomingBooking,
  });
}

class HomeBookingError extends HomeBookingState {
  final String errorMessage;
  HomeBookingError({
    required this.errorMessage,
    required super.listOngoingBooking,
    required super.listUpcomingBooking,
  });
}
