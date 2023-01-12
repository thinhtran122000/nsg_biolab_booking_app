import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../index.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  FavouriteBookingRepository favouriteBookingRepository;
  RefreshController equipmentRefreshController = RefreshController();
  int pageEquipment = 1;
  bool canTapLike = true;
  EquipmentBloc(this.favouriteBookingRepository) : super(EquipmentInitial()) {
    on<FetchDataEquipmentEvent>(_onFetchDataEquipmentEvent);
    on<ToggleLikeEquipmentEvent>(_onToggleLikeEquipmentEvent);
    on<LoadMoreEquipmentEvent>(_onLoadMoreEquipmentEvent);
  }

  FutureOr<void> _onFetchDataEquipmentEvent(
      FetchDataEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      pageEquipment = 1;
      var equipmentResult = await favouriteBookingRepository.getFavouriteEquipmentItems(
        page: pageEquipment,
        perPage: 10,
        dataMode: 'equipment_items',
      );
      if (equipmentResult.list.isNotEmpty) {
        pageEquipment++;
        emit(EquipmentSuccess(listEquipment: equipmentResult.list));
      } else {
        emit(EquipmentSuccess(listEquipment: equipmentResult.list));
      }
      equipmentRefreshController.refreshCompleted();
    } catch (e) {
      equipmentRefreshController.refreshFailed();
      emit(EquipmentError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onLoadMoreEquipmentEvent(
      LoadMoreEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      equipmentRefreshController.requestLoading();
      var curentListEquipment = (state as EquipmentSuccess).listEquipment;
      var equipmentResult = await favouriteBookingRepository.getFavouriteEquipmentItems(
        page: pageEquipment,
        perPage: 10,
        dataMode: 'equipment_items',
      );
      if (equipmentResult.list.isEmpty) {
        equipmentRefreshController.loadNoData();
      } else {
        pageEquipment++;
        var newListEquipment = List<EquipmentItem>.from(curentListEquipment)
          ..addAll(equipmentResult.list);
        emit(EquipmentSuccess(listEquipment: newListEquipment));
      }
      equipmentRefreshController.loadComplete();
    } catch (e) {
      equipmentRefreshController.loadFailed();
      emit(EquipmentError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onToggleLikeEquipmentEvent(
      ToggleLikeEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          canTapLike = false;
        },
      ).then((value) => canTapLike = true);
      await favouriteBookingRepository.toggleLikeFavouriteEquipmentItem(
          id: event.favouriteEquipment.id ?? 0);
      emit(
        EquipmentLikeSuccess(
          favouriteEquipment: event.favouriteEquipment,
        ),
      );
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString()));
    }
  }
}
