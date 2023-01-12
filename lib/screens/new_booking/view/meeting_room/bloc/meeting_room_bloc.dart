import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/meeting_rooms/new_meeting_room_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../index.dart';

part 'meeting_room_event.dart';
part 'meeting_room_state.dart';

class MeetingRoomBloc extends Bloc<MeetingRoomEvent, MeetingRoomState> {
  NewBookingRepository newBookingRepository;
  RefreshController meetingRoomRefreshController = RefreshController();
  ScrollController meetingRoomScrollController = ScrollController();
  TextEditingController meetingRoomTextEditingController = TextEditingController();
  int pageMeetingRoom = 1;
  bool canTapLike = true;
  bool visibleButton = false;
  MeetingRoomBloc(this.newBookingRepository) : super(MeetingRoomInitial(listMeetingRoom: [])) {
    on<FetchDataMeetingRoomEvent>(_onFetchDataMeetingRoomEvent);
    on<LoadMoreMeetingRoomEvent>(_onLoadMoreMeetingRoomEvent);
    on<ToggleLikeMeetingRoomEvent>(_onToggleLikeMeetingRoomEvent);
    on<ShowButtonScrollTopEvent>(_onShowButtonScrollTopEvent);
    on<ScrollTopEvent>(_onScrollTopEvent);
  }

  FutureOr<void> _onFetchDataMeetingRoomEvent(
      FetchDataMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      pageMeetingRoom = 1;
      var meetingRoomResult = await newBookingRepository.getNewBookingMeetingRooms(
        page: pageMeetingRoom,
        perPage: 5,
        keywords: meetingRoomTextEditingController.text,
      );
      if (meetingRoomResult.list.isNotEmpty) {
        pageMeetingRoom = 1;
        pageMeetingRoom++;
        emit(MeetingRoomSuccess(listMeetingRoom: meetingRoomResult.list));
      } else {
        emit(MeetingRoomSuccess(listMeetingRoom: meetingRoomResult.list));
      }
      meetingRoomRefreshController.refreshCompleted();
    } catch (e) {
      meetingRoomRefreshController.refreshFailed();
      emit(MeetingRoomError(errorMessage: e.toString(), listMeetingRoom: state.listMeetingRoom));
    }
  }

  FutureOr<void> _onLoadMoreMeetingRoomEvent(
      LoadMoreMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      meetingRoomRefreshController.requestLoading();
      var currentMeetingRoom = (state as MeetingRoomSuccess).listMeetingRoom;
      var meetingRoomResult = await newBookingRepository.getNewBookingMeetingRooms(
        page: pageMeetingRoom,
        perPage: 5,
        keywords: meetingRoomTextEditingController.text,
      );
      if (meetingRoomResult.list.isEmpty) {
        meetingRoomRefreshController.loadNoData();
      } else {
        pageMeetingRoom++;
        var newlistMeetingRoom = List<MeetingRoomItem>.from(currentMeetingRoom)
          ..addAll(meetingRoomResult.list);
        emit(MeetingRoomSuccess(listMeetingRoom: newlistMeetingRoom));
      }
      meetingRoomRefreshController.loadComplete();
    } catch (e) {
      meetingRoomRefreshController.loadFailed();
      emit(MeetingRoomError(errorMessage: e.toString(), listMeetingRoom: state.listMeetingRoom));
    }
  }

  FutureOr<void> _onToggleLikeMeetingRoomEvent(
      ToggleLikeMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          canTapLike = false;
        },
      ).then((value) => canTapLike = true);
      var newListMeetingRoom = [...state.listMeetingRoom];
      var index =
          newListMeetingRoom.indexWhere((element) => element.id == event.meetingRoomItem.id);
      if (index >= 0) {
        var toggleLikeMeetingRoomResult = await newBookingRepository
            .toggleLikeNewBookingMeetingRoomsItem(id: event.meetingRoomItem.id ?? 0);
        newListMeetingRoom[index].isLiked = toggleLikeMeetingRoomResult.object.isLiked;
      }
      emit(
        MeetingRoomLikeSuccess(
          listMeetingRoom: newListMeetingRoom,
          meetingRoomItem: event.meetingRoomItem,
        ),
      );
      emit(MeetingRoomSuccess(listMeetingRoom: newListMeetingRoom));
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString(), listMeetingRoom: state.listMeetingRoom));
    }
  }

  FutureOr<void> _onShowButtonScrollTopEvent(
      ShowButtonScrollTopEvent event, Emitter<MeetingRoomState> emit) {
    try {
      meetingRoomScrollController.addListener(() {
        if (meetingRoomScrollController.offset > 90) {
          visibleButton = true;
        } else {
          visibleButton = false;
        }
      });
      emit(MeetingRoomSuccess(listMeetingRoom: state.listMeetingRoom));
    } catch (e) {
      emit(MeetingRoomError(
        errorMessage: e.toString(),
        listMeetingRoom: state.listMeetingRoom,
      ));
    }
  }

  FutureOr<void> _onScrollTopEvent(ScrollTopEvent event, Emitter<MeetingRoomState> emit) {
    try {
      meetingRoomScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
      emit(MeetingRoomSuccess(listMeetingRoom: state.listMeetingRoom));
    } catch (e) {
      emit(MeetingRoomError(
        errorMessage: e.toString(),
        listMeetingRoom: state.listMeetingRoom,
      ));
    }
  }
}
