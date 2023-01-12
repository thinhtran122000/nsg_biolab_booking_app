import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/equipment_items/new_equipment_items_model.dart';
import 'package:domain/models/site.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../index.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  NewBookingRepository newBookingRepository;
  RefreshController equipmentRefreshController = RefreshController();
  ScrollController equipmentScrollController = ScrollController();
  TextEditingController equipmentTextEditingController = TextEditingController();
  int pageEquipment = 1;
  bool canTapLike = true;
  bool visibleButton = false;
  EquipmentBloc(this.newBookingRepository)
      : super(EquipmentInitial(
          listEquipment: [],
          levels: [],
          sites: [],
        )) {
    on<FetchDataEquipmentEvent>(_onFetchDataEquipmentEvent);
    on<LoadMoreEquipmentEvent>(_onLoadMoreEquipmentEvent);
    on<ToggleLikeEquipmentEvent>(_onToggleLikeEquipmentEvent);
    on<ShowButtonScrollTopEvent>(_onShowButtonScrollTopEvent);
    on<ScrollTopEvent>(_onScrollTopEvent);
    on<SetDatFilter>(_onSetDatFilter);
  }

  FutureOr<void> _onFetchDataEquipmentEvent(
      FetchDataEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      pageEquipment = 1;
      var equipmentResult = await newBookingRepository.getNewBookingEquipmentItems(
        page: pageEquipment,
        perPage: 10,
        levels: event.levels,
        sites: (event.sites ?? []).map((e) => e.id ?? 0).toList(),
        keywords: equipmentTextEditingController.text,
      );
      if (equipmentResult.list.isNotEmpty) {
        pageEquipment = 1;
        pageEquipment++;
        emit(EquipmentSuccess(listEquipment: equipmentResult.list));
      } else {
        emit(EquipmentSuccess(listEquipment: equipmentResult.list));
      }
      equipmentRefreshController.refreshCompleted();
    } catch (e) {
      equipmentRefreshController.refreshFailed();
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
    }
  }

  FutureOr<void> _onLoadMoreEquipmentEvent(
      LoadMoreEquipmentEvent event, Emitter<EquipmentState> emit) async {
    try {
      equipmentRefreshController.requestLoading();
      var curentListEquipment = (state as EquipmentSuccess).listEquipment;
      var equipmentResult = await newBookingRepository.getNewBookingEquipmentItems(
        page: pageEquipment,
        perPage: 10,
        levels: event.levels,
        sites: (event.sites ?? []).map((e) => e.id ?? 0).toList(),
        keywords: equipmentTextEditingController.text,
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
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
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
      var newListEquipment = [...state.listEquipment];
      var index = newListEquipment.indexWhere((element) => element.id == event.equipmentItem.id);
      if (index >= 0) {
        var toggleLikeEquipmentResult = await newBookingRepository
            .toggleLikeNewBookingEquipmentItem(id: event.equipmentItem.id ?? 0);
        newListEquipment[index].isLiked = toggleLikeEquipmentResult.object.isLiked;
        emit(EquipmentLikeSuccess(
          listEquipment: newListEquipment,
          equipmentItem: event.equipmentItem,
        ));
        emit(EquipmentSuccess(listEquipment: newListEquipment));
      }
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
    }
  }

  FutureOr<void> _onShowButtonScrollTopEvent(
      ShowButtonScrollTopEvent event, Emitter<EquipmentState> emit) {
    try {
      equipmentScrollController.addListener(() {
        if (equipmentScrollController.offset > 90) {
          visibleButton = true;
        } else {
          visibleButton = false;
        }
      });
      emit(EquipmentSuccess(listEquipment: state.listEquipment));
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
    }
  }

  FutureOr<void> _onScrollTopEvent(ScrollTopEvent event, Emitter<EquipmentState> emit) {
    try {
      equipmentScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
      emit(EquipmentSuccess(listEquipment: state.listEquipment));
    } catch (e) {
      emit(EquipmentError(errorMessage: e.toString(), listEquipment: state.listEquipment));
    }
  }

  FutureOr<void> _onSetDatFilter(SetDatFilter event, Emitter<EquipmentState> emit) {
    emit(EquipmentInitial(
      listEquipment: state.listEquipment,
      levels: event.levels,
      sites: event.sites,
    ));
  }
}
