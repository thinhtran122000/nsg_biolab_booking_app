part of 'global_bloc.dart';

abstract class GlobalState {
  final List<EquipmentItem> listEquipment; // quản lý list equipment trong favorite
  final List<MeetingRoomItem> listMeetingRoom; // quản lý list meeting room trong favorite
  final List<EquipmentItem> listNewEquipment; // quản lý list equipment trong new booking
  final List<MeetingRoomItem> listNewMeetingRoom; // quản lý list meeting room trong new booking
  final List<OngoingBooking> listOngoingBooking; // quản lý list ongoing booking
  final List<UpcomingBooking> listUpcomingBooking; // quản lý list upcoming booking
  final OngoingBooking? ongoingBooking; // quản lý details ongoing booking
  final UpcomingBooking? upcomingBooking; // quản lý details upcoming booking
  GlobalState({
    required this.listEquipment,
    required this.listMeetingRoom,
    required this.listNewEquipment,
    required this.listNewMeetingRoom,
    required this.listOngoingBooking,
    required this.listUpcomingBooking,
    required this.ongoingBooking,
    required this.upcomingBooking,
  });
}

class GlobalInitial extends GlobalState {
  GlobalInitial({
    required super.listEquipment,
    required super.listMeetingRoom,
    required super.listNewEquipment,
    required super.listNewMeetingRoom,
    required super.listOngoingBooking,
    required super.listUpcomingBooking,
    super.ongoingBooking,
    super.upcomingBooking,
  });
}
