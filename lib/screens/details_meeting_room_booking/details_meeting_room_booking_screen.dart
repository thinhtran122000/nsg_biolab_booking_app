import 'package:domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/index.dart';
import '../edit_booking/edit_booking_screen.dart';
import 'bloc/details_meeting_room_booking_bloc.dart';
import 'widgets/text_widget_meeting_room_details.dart';

class DetailsMeetingRoomBookingScreen extends StatelessWidget {
  const DetailsMeetingRoomBookingScreen({
    super.key,
    this.ongoingBooking,
    this.upcomingBooking,
    required this.checkBooking,
  });
  final OngoingBooking? ongoingBooking;
  final UpcomingBooking? upcomingBooking;
  final bool checkBooking;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsMeetingRoomBookingBloc()
        ..add(FetchDataDetailsMeetingRoomEvent(
          ongoingBookingMeetingRoom: ongoingBooking,
          upcomingBookingMeetingRoom: upcomingBooking,
        )),
      child: BlocBuilder<DetailsMeetingRoomBookingBloc, DetailsMeetingRoomBookingState>(
        buildWhen: (previous, current) {
          if (current is DetailsMeetingRoomBookingSuccess) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is DetailsMeetingRoomBookingSuccess) {
            return Scaffold(
              appBar: CustomAppBar(
                titleAppBar: 'View Booking',
                visibleAction: true,
                visibleLeading: true,
                onPressLeading: () => Navigator.of(context).pop(),
                onPressAction: () => Navigator.of(context).push(
                  HorizontalNavigatorRoute(
                    begin: const Offset(1, 0),
                    page: EditBookingScreen(
                      ongoingBooking: state.ongoingBookingMeetingRoom,
                      upcomingBooking: state.upcomingBookingMeetingRoom,
                    ),
                  ),
                ),
                iconAction: Icon(
                  Icons.edit,
                  color: greenColor,
                  size: 25,
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgetMeetingRoomDetails(
                        data: 'Room Name',
                        textStyle: superLargeBlackBlurMediumFuturaTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetMeetingRoomDetails(
                        data: checkMeetingRoomName(
                          checkBooking
                              ? state.ongoingBookingMeetingRoom
                              : state.upcomingBookingMeetingRoom,
                        ),
                        textStyle: superLargeBlackHeavyFuturaTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetMeetingRoomDetails(
                        data: 'Location',
                        textStyle: superLargeBlackBlurMediumFuturaTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetMeetingRoomDetails(
                        data: checkMeetingRoomLevelAndSiteName(
                          checkBooking
                              ? state.ongoingBookingMeetingRoom
                              : state.upcomingBookingMeetingRoom,
                        ),
                        textStyle: superLargeBlackHeavyFuturaTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetMeetingRoomDetails(
                        data: 'Datetime',
                        textStyle: superLargeBlackBlurMediumFuturaTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetMeetingRoomDetails(
                        data: checkMeetingRoomDateTime(
                          checkBooking
                              ? state.ongoingBookingMeetingRoom
                              : state.upcomingBookingMeetingRoom,
                        ),
                        textStyle: superLargeBlackHeavyFuturaTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  String checkMeetingRoomName(Object? booking) {
    if (booking is OngoingBooking) {
      return booking.orderable?.name ?? '';
    } else if (booking is UpcomingBooking) {
      return booking.orderable?.name ?? '';
    } else {
      return '';
    }
  }

  String checkMeetingRoomLevelAndSiteName(Object? booking) {
    if (booking is OngoingBooking) {
      return 'Level ${booking.orderable?.site?.level}, ${booking.orderable?.site?.name}';
    } else if (booking is UpcomingBooking) {
      return 'Level ${booking.orderable?.site?.level}, ${booking.orderable?.site?.name}';
    } else {
      return '';
    }
  }

  String checkMeetingRoomDateTime(Object? booking) {
    if (booking is OngoingBooking) {
      var ongoingBookingStartDate =
          Utilities().dateFormat(booking.startDate ?? DateTime.now(), 'MMM d (EEE)');
      var ongoingBookingEndDate =
          Utilities().dateFormat(booking.endDate ?? DateTime.now(), 'MMM d (EEE)');
      var ongoingBookingStartTime =
          Utilities().timeFormat(Utilities().convertDoubleToTime(booking.startTime ?? 0));
      var ongoingBookingEndTime =
          Utilities().timeFormat(Utilities().convertDoubleToTime(booking.endTime ?? 0));
      return '$ongoingBookingStartDate - $ongoingBookingEndDate \n$ongoingBookingStartTime - $ongoingBookingEndTime';
    } else if (booking is UpcomingBooking) {
      var upcomingBookingStartDate =
          Utilities().dateFormat(booking.startDate ?? DateTime.now(), 'MMM d (EEE)');
      var upcomingBookingEndDate =
          Utilities().dateFormat(booking.endDate ?? DateTime.now(), 'MMM d (EEE)');
      var upcomingBookingStartTime =
          Utilities().timeFormat(Utilities().convertDoubleToTime(booking.startTime ?? 0));
      var upcomingBookingEndTime =
          Utilities().timeFormat(Utilities().convertDoubleToTime(booking.endTime ?? 0));
      return '$upcomingBookingStartDate - $upcomingBookingEndDate \n$upcomingBookingStartTime - $upcomingBookingEndTime';
    } else {
      return '';
    }
  }
}
