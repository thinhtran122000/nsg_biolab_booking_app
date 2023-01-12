part of 'meeting_room_bloc.dart';

abstract class MeetingRoomEvent {}

class FetchDataMeetingRoomEvent extends MeetingRoomEvent {}

class LoadMoreMeetingRoomEvent extends MeetingRoomEvent {}

class ToggleLikeMeetingRoomEvent extends MeetingRoomEvent {
  final MeetingRoomItem favouriteMeetingRoom;

  ToggleLikeMeetingRoomEvent({
    required this.favouriteMeetingRoom,
  });
}
