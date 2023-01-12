import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/models/models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../index.dart';

part 'meeting_room_event.dart';
part 'meeting_room_state.dart';

class MeetingRoomBloc extends Bloc<MeetingRoomEvent, MeetingRoomState> {
  FavouriteBookingRepository favouriteBookingRepository;
  RefreshController meetingRoomRefreshController = RefreshController();
  int pageMeetingRoom = 1;
  bool canTapLike = true;
  MeetingRoomBloc(this.favouriteBookingRepository) : super(MeetingRoomInitial()) {
    on<FetchDataMeetingRoomEvent>(_onFetchDataMeetingRoomEvent);
    on<ToggleLikeMeetingRoomEvent>(_onToggleLikeMeetingRoomEvent);
    on<LoadMoreMeetingRoomEvent>(_onLoadMoreMeetingRoomEvent);
  }

  FutureOr<void> _onFetchDataMeetingRoomEvent(
      FetchDataMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      pageMeetingRoom = 1;
      var meetingRoomResult = await favouriteBookingRepository.getFavouriteMeetingRooms(
        page: pageMeetingRoom,
        perPage: 5,
        dataMode: 'meeting_rooms',
      );
      if (meetingRoomResult.list.isNotEmpty) {
        pageMeetingRoom++;
        emit(MeetingRoomSuccess(listMeetingRoom: meetingRoomResult.list));
      } else {
        emit(MeetingRoomSuccess(listMeetingRoom: meetingRoomResult.list));
      }
      meetingRoomRefreshController.refreshCompleted();
    } catch (e) {
      meetingRoomRefreshController.refreshFailed();
      emit(MeetingRoomError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onLoadMoreMeetingRoomEvent(
      LoadMoreMeetingRoomEvent event, Emitter<MeetingRoomState> emit) async {
    try {
      meetingRoomRefreshController.requestLoading();
      var currentMeetingRoom = (state as MeetingRoomSuccess).listMeetingRoom;
      var meetingRoomResult = await favouriteBookingRepository.getFavouriteMeetingRooms(
        page: pageMeetingRoom,
        perPage: 5,
        dataMode: 'meeting_rooms',
      );
      if (meetingRoomResult.list.isEmpty) {
        meetingRoomRefreshController.loadNoData();
      } else {
        pageMeetingRoom++;
        var newListMeetingRoom = List<MeetingRoomItem>.from(currentMeetingRoom)
          ..addAll(meetingRoomResult.list);
        emit(MeetingRoomSuccess(listMeetingRoom: newListMeetingRoom));
      }
      meetingRoomRefreshController.loadComplete();
    } catch (e) {
      meetingRoomRefreshController.loadFailed();
      emit(MeetingRoomError(errorMessage: e.toString()));
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
      await favouriteBookingRepository.toggleLikeFavouriteMeetingRoomsItem(
          id: event.favouriteMeetingRoom.id ?? 0);
      emit(MeetingRoomLikeSuccess(favouriteMeetingRoom: event.favouriteMeetingRoom));
    } catch (e) {
      emit(MeetingRoomError(errorMessage: e.toString()));
    }
  }
}
