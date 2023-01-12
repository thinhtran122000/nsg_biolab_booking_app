import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:codebase/screens/favourite_booking/view/equipment/favourite_equipment_view.dart';
import 'package:flutter/material.dart';

import '../view/meeting_room/favourite_meeting_room_view.dart';

part 'favourite_booking_event.dart';
part 'favourite_booking_state.dart';

class FavouriteBookingBloc extends Bloc<FavouriteBookingEvent, FavouriteBookingState> {
  FavouriteBookingBloc()
      : super(
          FavouriteBookingInitial(
            indexView: 0,
            listView: [
              const FavouriteEquipmentView(),
              const FavouriteMeetingRoomView(),
            ],
          ),
        ) {
    on<ChangeTabEvent>(_onChangeTabEvent);
  }

  FutureOr<void> _onChangeTabEvent(ChangeTabEvent event, Emitter<FavouriteBookingState> emit) {
    // state.listView.elementAt(event.indexView);
    emit(
      FavouriteBookingInitial(
        indexView: event.indexView,
        listView: state.listView,
      ),
    );
  }
}
