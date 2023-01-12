part of 'favourite_booking_bloc.dart';

abstract class FavouriteBookingState {
  final List<StatelessWidget> listView;
  final int indexView;
  FavouriteBookingState({
    required this.listView,
    required this.indexView,
  });
}

class FavouriteBookingInitial extends FavouriteBookingState {
  FavouriteBookingInitial({
    required super.listView,
    required super.indexView,
  });
}
