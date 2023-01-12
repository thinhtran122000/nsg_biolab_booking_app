import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/bookings/ongoing_booking_model.dart';
import 'package:domain/models/bookings/upcoming_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../index.dart';

part 'home_booking_event.dart';
part 'home_booking_state.dart';

class HomeBookingBloc extends Bloc<HomeBookingEvent, HomeBookingState> {
  RefreshController refreshController = RefreshController();
  HomeBookingRepository homeBookingRepository;
  ScrollController homeScrollController = ScrollController();
  int pageUpcoming = 1;
  bool visibleButton = false;
  HomeBookingBloc(this.homeBookingRepository)
      : super(
          HomeBookingSucess(listOngoingBooking: [], listUpcomingBooking: []),
        ) {
    on<FetchDataHomeBookingEvent>(_onFetchDataUpcomingBookingEvent);
    on<LoadMoreUpcomingBookingEvent>(_onLoadMoreUpcomingBookingEvent);
    on<ShowButtonScrollTopEvent>(_onShowButtonScrollTopEvent);
    on<ScrollTopEvent>(_onScrollTopEvent);
  }
  FutureOr<void> _onFetchDataUpcomingBookingEvent(
      FetchDataHomeBookingEvent event, Emitter<HomeBookingState> emit) async {
    try {
      pageUpcoming = 1;
      var ongoingResult = await homeBookingRepository.getOngoingBookings();
      var upcomingResult = await homeBookingRepository.getUpcomingBookings(
        page: pageUpcoming,
        perPage: 10,
      );
      if (upcomingResult.list.isNotEmpty) {
        pageUpcoming++;
        emit(
          HomeBookingSucess(
            listUpcomingBooking: upcomingResult.list,
            listOngoingBooking: ongoingResult.list,
          ),
        );
      } else {
        emit(
          HomeBookingSucess(
            listUpcomingBooking: upcomingResult.list,
            listOngoingBooking: ongoingResult.list,
          ),
        );
      }
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
      emit(HomeBookingError(
        errorMessage: e.toString(),
        listOngoingBooking: state.listOngoingBooking,
        listUpcomingBooking: state.listUpcomingBooking,
      ));
    }
  }

  FutureOr<void> _onLoadMoreUpcomingBookingEvent(
      LoadMoreUpcomingBookingEvent event, Emitter<HomeBookingState> emit) async {
    try {
      refreshController.requestLoading();
      var curentListUpcoming = state.listUpcomingBooking;
      var upcomingResult = await homeBookingRepository.getUpcomingBookings(
        page: pageUpcoming,
        perPage: 10,
      );
      if (upcomingResult.list.isEmpty) {
        refreshController.loadNoData();
      } else {
        pageUpcoming++;
        var newListUpcoming = List<UpcomingBooking>.from(curentListUpcoming)
          ..addAll(upcomingResult.list);
        emit(
          HomeBookingSucess(
            listOngoingBooking:state.listOngoingBooking,
            listUpcomingBooking: newListUpcoming,
          ),
        );
      }
      refreshController.loadComplete();
    } catch (e) {
      refreshController.loadFailed();
      emit(HomeBookingError(
        errorMessage: e.toString(),
        listOngoingBooking: state.listOngoingBooking,
        listUpcomingBooking: state.listUpcomingBooking,
      ));
    }
  }

  FutureOr<void> _onShowButtonScrollTopEvent(
      ShowButtonScrollTopEvent event, Emitter<HomeBookingState> emit) {
    try {
      homeScrollController.addListener(() {
        if (homeScrollController.offset > 200) {
          visibleButton = true;
        } else {
          visibleButton = false;
        }
      });
      emit(
        HomeBookingSucess(
          listOngoingBooking: event.listOngoingBooking,
          listUpcomingBooking: event.listUpcomingBooking,
        ),
      );
    } catch (e) {
      emit(HomeBookingError(
        errorMessage: e.toString(),
        listOngoingBooking: state.listOngoingBooking,
        listUpcomingBooking: state.listUpcomingBooking,
      ));
    }
  }

  FutureOr<void> _onScrollTopEvent(ScrollTopEvent event, Emitter<HomeBookingState> emit) {
    try {
      homeScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
      emit(
        HomeBookingSucess(
          listOngoingBooking: event.listOngoingBooking,
          listUpcomingBooking: event.listUpcomingBooking,
        ),
      );
    } catch (e) {
      emit(HomeBookingError(
        errorMessage: e.toString(),
        listOngoingBooking: state.listOngoingBooking,
        listUpcomingBooking: state.listUpcomingBooking,
      ));
    }
  }
}
