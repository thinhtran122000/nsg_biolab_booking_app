import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/index.dart';
import '../edit_booking/edit_booking_screen.dart';
import 'bloc/details_equipment_booking_bloc.dart';
import 'widgets/text_widget_equipment_details.dart';

class DetailsEquipmentBookingScreen extends StatelessWidget {
  const DetailsEquipmentBookingScreen({
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
      create: (context) => DetailsEquipmentBookingBloc()
        ..add(FetchDataDetailsEquipmentEvent(
          ongoingBookingEquipment: ongoingBooking,
          upcomingBookingEquipment: upcomingBooking,
        )),
      child: BlocBuilder<DetailsEquipmentBookingBloc, DetailsEquipmentBookingState>(
        buildWhen: (previous, current) {
          if (current is DetailsEquipmentBookingSuccess) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is DetailsEquipmentBookingSuccess) {
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
                      ongoingBooking: state.ongoingBookingEquipment,
                      upcomingBooking: state.upcomingBookingEquipment,
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
                      TextWidgetEquipmentDetails(
                        data: 'Equipment Name',
                        textStyle: superLargeBlackBlurMediumFuturaTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetEquipmentDetails(
                        data: checkEquipmentName(
                          checkBooking
                              ? state.ongoingBookingEquipment
                              : state.upcomingBookingEquipment,
                        ),
                        textStyle: superLargeBlackHeavyFuturaTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetEquipmentDetails(
                        data: 'Equipment ID',
                        textStyle: superLargeBlackBlurMediumFuturaTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetEquipmentDetails(
                        data: checkEquipmentId(
                          checkBooking
                              ? state.ongoingBookingEquipment
                              : state.upcomingBookingEquipment,
                        ),
                        textStyle: superLargeBlackHeavyFuturaTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetEquipmentDetails(
                        data: 'Location',
                        textStyle: superLargeBlackBlurMediumFuturaTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetEquipmentDetails(
                        data: checkEquipmentLevelAndSiteName(
                          checkBooking
                              ? state.ongoingBookingEquipment
                              : state.upcomingBookingEquipment,
                        ),
                        textStyle: superLargeBlackHeavyFuturaTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetEquipmentDetails(
                        data: 'Datetime',
                        textStyle: superLargeBlackBlurMediumFuturaTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetEquipmentDetails(
                        data: checkEquipmentDateTime(
                          checkBooking
                              ? state.ongoingBookingEquipment
                              : state.upcomingBookingEquipment,
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

  String checkEquipmentName(Object? booking) {
    if (booking is OngoingBooking) {
      return booking.orderable?.name ?? '';
    } else if (booking is UpcomingBooking) {
      return booking.orderable?.name ?? '';
    } else {
      return '';
    }
  }

  String checkEquipmentId(Object? booking) {
    if (booking is OngoingBooking) {
      return 'NSG-00${booking.orderable?.id}';
    } else if (booking is UpcomingBooking) {
      return 'NSG-00${booking.orderable?.id}';
    } else {
      return '';
    }
  }

  String checkEquipmentLevelAndSiteName(Object? booking) {
    if (booking is OngoingBooking) {
      return 'Level ${booking.orderable?.site?.level}, ${booking.orderable?.site?.name}';
    } else if (booking is UpcomingBooking) {
      return 'Level ${booking.orderable?.site?.level}, ${booking.orderable?.site?.name}';
    } else {
      return '';
    }
  }

  String checkEquipmentDateTime(Object? booking) {
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
