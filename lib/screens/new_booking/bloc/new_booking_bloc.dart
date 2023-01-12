import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/sites/filter_model.dart';

part 'new_booking_event.dart';
part 'new_booking_state.dart';

class NewBookingBloc extends Bloc<NewBookingEvent, NewBookingState> {
  NewBookingBloc() : super(NewBookingInitial(visibleFilterIcon: true, indexView: 0,resultFilter: null)) {
    on<ChangeTabEvent>(_onChangeTabEvent);
    on<SetDataFilter>(_onSetDataFilter);
  }

  FutureOr<void> _onChangeTabEvent(ChangeTabEvent event, Emitter<NewBookingState> emit) {
    if (event.indexView == 0) {
      emit(
        NewBookingInitial(
          visibleFilterIcon: true,
          indexView: event.indexView,
        ),
      );
    } else {
      emit(
        NewBookingInitial(
          visibleFilterIcon: false,
          indexView: event.indexView,
        ),
      );
    }
  }

  FutureOr<void> _onSetDataFilter(SetDataFilter event, Emitter<NewBookingState> emit) {
    emit(NewBookingInitial(
      visibleFilterIcon: state.visibleFilterIcon,
      indexView: state.indexView,
      resultFilter: event.resultsFilter
    ));
  }
}
