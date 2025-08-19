import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/site.dart';
import 'package:domain/models/sites/filter_model.dart';
import 'package:nsg_biolab_booking_app/screens/filter_search_booking/filter_search_booking_repository.dart';

part 'filter_search_event.dart';
part 'filter_search_state.dart';

class FilterSearchBloc extends Bloc<FilterSearchEvent, FilterSearchState> {
  FilterSearchBookingRepository filterSearchBookingRepository;
  List<bool> isCheckedLevel = List.filled(2, false);
  List<bool> isCheckedRoom = List.filled(8, false);
  FilterSearchBloc(this.filterSearchBookingRepository)
      : super(FilterSearchSuccess(
          listLevel: [],
          listSite: [],
        )) {
    on<FetchDataFilterEvent>(_onFetchDataFilter);
    on<CheckLevelEvent>(_onCheckLevelEvent);
    on<CheckRoomEvent>(_onCheckRoomEvent);
    on<FilterEvent>(_onFilterEvent);
    on<ResetLevelFilterEvent>(_onResetLevelFilterEvent);
    on<ResetSiteRoomFilterEvent>(_onResetSiteRoomFilterEvent);
  }

  FutureOr<void> _onFetchDataFilter(FetchDataFilterEvent event, Emitter<FilterSearchState> emit) async {
    try {
      final response = await filterSearchBookingRepository.getFilter();
      emit(FilterSearchSuccess(
        listLevel: response.object.levels ?? [],
        listSite: response.object.sites ?? [],
      ));
      // thuật toán tìm kiếm tuần tự giữa 2 list
      var listLevel = event.filterModel?.levels;
      var listSite = event.filterModel?.sites;
      if (listLevel!.length == 2 && listSite!.length == 8) {
        isCheckedLevel = List.filled(2, true);
        isCheckedRoom = List.filled(8, true);
      } else if (listLevel.length == 2 && listSite!.length != 8) {
        isCheckedLevel = List.filled(2, true);
        for (int i = 0; i < listSite.length; i++) {
          for (int j = 0; j < state.listSite.length; j++) {
            if ((state.listSite[j].name ?? '').contains(listSite[i].name ?? '')) {
              if (state.listSite[j].level.toString().contains(listSite[i].level.toString())) {
                isCheckedRoom[j] = true;
                i++;
                continue;
              } else {
                isCheckedRoom[j] = false;
                continue;
              }
            } else {
              isCheckedRoom[j] = false;
              continue;
            }
          }
        }
      } else if (listLevel.length != 2 && listSite!.length == 8) {
        isCheckedRoom = List.filled(8, true);
        for (int i = 0; i < listLevel.length; i++) {
          for (int j = 0; j < state.listLevel.length; j++) {
            if (state.listLevel[j].toString().contains(listLevel[i].toString())) {
              isCheckedLevel[j] = true;
              i++;
              j++;
              continue;
            } else {
              isCheckedLevel[j] = false;
              continue;
            }
          }
        }
      } else {
        for (int i = 0; i < listLevel.length; i++) {
          for (int j = 0; j < state.listLevel.length; j++) {
            if (state.listLevel[j].toString().contains(listLevel[i].toString())) {
              isCheckedLevel[j] = true;
              i++;
              j++;
              continue;
            } else {
              isCheckedLevel[j] = false;
              continue;
            }
          }
        }
        for (int i = 0; i < listSite!.length; i++) {
          for (int j = 0; j < state.listSite.length; j++) {
            if ((state.listSite[j].name ?? '').contains(listSite[i].name ?? '')) {
              if (state.listSite[j].level.toString().contains(listSite[i].level.toString())) {
                isCheckedRoom[j] = true;
                i++;
                continue;
              } else {
                isCheckedRoom[j] = false;
                continue;
              }
            } else {
              isCheckedRoom[j] = false;
              continue;
            }
          }
        }
      }
    } catch (e) {
      emit(FilterSearchError(
        listLevel: state.listLevel,
        listSite: state.listSite,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onFilterEvent(FilterEvent event, Emitter<FilterSearchState> emit) {
    var curentlistFilterLevel = [...?state.listFilterLevel];
    var curentlistFilterSite = [...?state.listFilterSite];
    for (int i = 0; i < isCheckedLevel.length; i++) {
      if (isCheckedLevel[i] == true) {
        curentlistFilterLevel.add(state.listLevel[i]);
      } else {
        curentlistFilterLevel.remove(state.listLevel[i]);
      }
    }
    for (int i = 0; i < isCheckedRoom.length; i++) {
      if (isCheckedRoom[i] == true) {
        curentlistFilterSite.add(state.listSite[i]);
      } else {
        curentlistFilterSite.remove(state.listSite[i]);
      }
    }
    emit(FilterSuccess(
      listLevel: state.listLevel,
      listSite: state.listSite,
      listFilterLevel: curentlistFilterLevel,
      listFilterSite: curentlistFilterSite,
    ));
    emit(FilterSearchSuccess(
      listLevel: state.listLevel,
      listSite: state.listSite,
    ));
  }

  FutureOr<void> _onCheckLevelEvent(CheckLevelEvent event, Emitter<FilterSearchState> emit) {
    try {
      isCheckedLevel[event.index] = !isCheckedLevel[event.index];

      emit(FilterSearchSuccess(
        listLevel: state.listLevel,
        listSite: state.listSite,
      ));
    } catch (e) {
      emit(FilterSearchError(
        listLevel: state.listLevel,
        listSite: state.listSite,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onCheckRoomEvent(CheckRoomEvent event, Emitter<FilterSearchState> emit) {
    try {
      isCheckedRoom[event.index] = !isCheckedRoom[event.index];
      emit(FilterSearchSuccess(
        listLevel: state.listLevel,
        listSite: state.listSite,
      ));
    } catch (e) {
      emit(FilterSearchError(listLevel: state.listLevel, listSite: state.listSite, errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onResetLevelFilterEvent(ResetLevelFilterEvent event, Emitter<FilterSearchState> emit) {
    try {
      isCheckedLevel = List.generate(2, (index) => false);
      emit(FilterSearchSuccess(
        listLevel: state.listLevel,
        listSite: state.listSite,
      ));
    } catch (e) {
      emit(FilterSearchError(
        listLevel: state.listLevel,
        listSite: state.listSite,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onResetSiteRoomFilterEvent(ResetSiteRoomFilterEvent event, Emitter<FilterSearchState> emit) {
    try {
      isCheckedRoom = List.generate(8, (index) => false);
      emit(FilterSearchSuccess(
        listLevel: state.listLevel,
        listSite: state.listSite,
      ));
    } catch (e) {
      emit(FilterSearchError(
        listLevel: state.listLevel,
        listSite: state.listSite,
        errorMessage: e.toString(),
      ));
    }
  }
}
