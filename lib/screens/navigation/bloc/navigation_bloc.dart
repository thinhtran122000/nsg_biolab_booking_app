import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../favourite_booking/favourite_booking_screen.dart';
import '../../home_booking/index.dart';
import '../../profile/profile_screen.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  int pageIndex = 0;

  NavigationBloc()
      : super(
          NavigationInitial(
            listPage: [
              const HomeBookingScreen(),
              const FavouriteBookingScreen(),
              const ProfileScreen(),
            ],
          ),
        ) {
    on<NavigateScreenEvent>(_onNavigateHomeScreenEvent);
  }

  FutureOr<void> _onNavigateHomeScreenEvent(
      NavigateScreenEvent event, Emitter<NavigationState> emit) {
    pageIndex = event.indexPage;
    emit(
      NavigationInitial(
        listPage: state.listPage,
      ),
    );
  }
}
