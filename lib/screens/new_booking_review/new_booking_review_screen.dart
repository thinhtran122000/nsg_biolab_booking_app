import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../blocs/bloc/global_bloc.dart';
import '../../utilities/index.dart';
import '../../utilities/rest_api_client/index.dart';
import '../edit_booking/widgets/index.dart';
import '../success_booking/success_booking_screen.dart';
import 'bloc/new_booking_review_bloc.dart';
import 'new_booking_review_repository.dart';

class NewBookingReviewScreen extends StatefulWidget {
  const NewBookingReviewScreen({
    super.key,
    this.equipmentItem,
    this.meetingRoomItem,
    required this.fromDate,
    required this.fromTime,
  });
  final EquipmentItem? equipmentItem;
  final MeetingRoomItem? meetingRoomItem;
  final DateTime fromDate;
  final DateTime fromTime;
  @override
  State<NewBookingReviewScreen> createState() => _NewBookingReviewScreenState();
}

class _NewBookingReviewScreenState extends State<NewBookingReviewScreen> {
  late DateTime fromDate = widget.fromDate;
  late DateTime toDate = Utilities().displayToTime(fromTime, widget.fromDate);
  late DateTime fromTime = widget.fromTime;
  late DateTime toTime = widget.fromTime.add(const Duration(hours: 1));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewBookingReviewBloc(NewBookingReviewRepository(restApiClient: RestAPIClient()))
            ..add(
              FetchDataBookingReviewEvent(
                equipmentItem: widget.equipmentItem,
                meetingRoomItem: widget.meetingRoomItem,
              ),
            ),
      child: BlocConsumer<NewBookingReviewBloc, NewBookingReviewState>(
        buildWhen: (previous, current) {
          if (current is NewBookingReviewInitial) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          if (state is NewBookingReviewSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(GlobalAddBooking(
              upcomingBooking: BlocProvider.of<NewBookingReviewBloc>(context).upcomingBooking,
            ));
            Future.delayed(
              const Duration(milliseconds: 500),
              () => Navigator.push(
                context,
                HorizontalNavigatorRoute(
                  begin: const Offset(1, 0),
                  page: const SuccessBookingScreen(),
                ),
              ),
            );
          } else if (state is NewBookingReviewError) {
            Future.delayed(
              const Duration(milliseconds: 500),
            ).then(
              (value) => showDialogError(context, state.errorMessage),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              titleAppBar: 'Review Booking',
              visibleLeading: true,
              onPressLeading: () => Navigator.of(context).pop(),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 31),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgetEditBooking(
                      data: getOrderbleTypeBooking(context),
                      textStyle: largeBlackLessBlurTextStyle,
                    ),
                    const SizedBox(height: 7),
                    Container(
                      width: 369,
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
                      decoration: BoxDecoration(
                        color: superLightGreyColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        border: Border.all(
                          width: 1,
                          color: lightGreyColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextWidgetEditBooking(
                          data: getDetailsBooking(context),
                          softWrap: false,
                          maxLinesText: 1,
                          textOverflow: TextOverflow.clip,
                          textStyle: contentEditBookingTextStyle(blackColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidgetEditBooking(
                          data: 'From',
                          textStyle: largeBlackLessBlurTextStyle,
                        ),
                        Text(
                          Utilities().validateDateTime(fromDate, toDate, fromTime, toTime),
                          style: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                              ? smallGreenTextStyle
                              : smallRedTextStyle,
                        )
                      ],
                    ),
                    const SizedBox(height: 7),
                    TextFieldDateTimeEditBooking(
                      childIcon: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                          ? Icon(Icons.check_circle_sharp, color: greenColor)
                          : const AlertIcon(),
                      hasBackGroundColor: false,
                      onTapDate: () async => await showFromDatePicker(context: context),
                      onTapTime: () async => await showFromTimePicker(context: context),
                      childTextDate: TextWidgetEditBooking(
                        data: Utilities().dateFormat(fromDate, 'dd MMM yyyy'),
                        textStyle: contentEditBookingTextStyle(blackColor),
                      ),
                      childTextTime: TextWidgetEditBooking(
                        data: Utilities().timeFormat(fromTime),
                        textStyle: contentEditBookingTextStyle(
                          Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                              ? blackColor
                              : redColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidgetEditBooking(
                          data: 'To',
                          textStyle: largeBlackLessBlurTextStyle,
                        ),
                        Text(
                          Utilities().validateDateTime(fromDate, toDate, fromTime, toTime),
                          style: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                              ? smallGreenTextStyle
                              : smallRedTextStyle,
                        )
                      ],
                    ),
                    const SizedBox(height: 7),
                    TextFieldDateTimeEditBooking(
                      childIcon: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                          ? Icon(Icons.check_circle_sharp, color: greenColor)
                          : const AlertIcon(),
                      onTapDate: () async => await showToDatePicker(context: context),
                      onTapTime: () async => await showToTimePicker(context: context),
                      childTextDate: TextWidgetEditBooking(
                        data: Utilities().dateFormat(toDate, 'dd MMM yyyy'),
                        textStyle: contentEditBookingTextStyle(blackColor),
                      ),
                      childTextTime: TextWidgetEditBooking(
                        data: Utilities().timeFormat(toTime),
                        textStyle: contentEditBookingTextStyle(
                          Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                              ? blackColor
                              : redColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: 369,
                      height: 48,
                      child: ConfirmButton(
                        style: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                            ? greenButtonStyle
                            : disableButtonStyle,
                        onPress: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                            ? () {
                                showProgressIndicator(context);
                                BlocProvider.of<NewBookingReviewBloc>(context).add(
                                  AddBookingEvent(
                                    orderableType: state.equipmentItem != null
                                        ? 'EquipmentItem'
                                        : 'MeetingRoom',
                                    orderableId: (state.equipmentItem != null
                                            ? state.equipmentItem?.id
                                            : state.meetingRoomItem?.id) ??
                                        0,
                                    fromDate: Utilities().convertDate(fromDate),
                                    toDate: Utilities().convertDate(toDate),
                                    fromTime: Utilities().convertTimeToDouble(fromTime),
                                    toTime: Utilities().convertTimeToDouble(toTime),
                                  ),
                                );
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showProgressIndicator(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Center(
          child: CupertinoActivityIndicator(
            radius: 30,
            color: greenColor,
          ),
        );
      },
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () => Navigator.of(context).pop(),
    );
  }

  showDialogError(BuildContext context, String errorMessage) => showDialog(
        context: context,
        builder: (context) => CustomDialog(
          height: 300,
          visibleBackButton: false,
          visibleConfirmButton: true,
          labelConfirmButton: 'OK',
          message: Utilities().formatErrorMessage(errorMessage),
          visibleDialogTitle: false,
          visibleMessage: true,
          colorConfirmButton: greenColor,
          onTapConfirmButton: () => Navigator.pop(context),
        ),
      );

  String getDetailsBooking(BuildContext context) {
    var state = BlocProvider.of<NewBookingReviewBloc>(context).state;
    if (state.equipmentItem != null) {
      return '${state.equipmentItem?.name} - Level ${state.equipmentItem?.site?.level}, ${state.equipmentItem?.site?.name}';
    } else {
      return '${state.meetingRoomItem?.name} - Level ${state.meetingRoomItem?.site?.level}, ${state.meetingRoomItem?.site?.name}';
    }
  }

  Future<void> showFromDatePicker({
    required BuildContext context,
  }) async =>
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => DateTimePickerBooking(
          modeDateTimePicker: CupertinoDatePickerMode.date,
          onPressCancel: () => Navigator.of(context).pop(),
          onPressDone: () {
            Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {}));
            Navigator.of(context).pop();
          },
          onDateTimeChanged: (picked) => fromDate = picked,
          initialDateTime: fromDate,
        ),
      ).then(
        (value) => showProgressIndicator(context),
      );

  Future<void> showToDatePicker({
    required BuildContext context,
  }) async =>
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => DateTimePickerBooking(
          modeDateTimePicker: CupertinoDatePickerMode.date,
          onPressCancel: () => Navigator.of(context).pop(),
          onPressDone: () {
            Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {}));
            Navigator.of(context).pop();
          },
          onDateTimeChanged: (picked) => toDate = picked,
          initialDateTime: toDate,
        ),
      ).then(
        (value) => showProgressIndicator(context),
      );

  Future<void> showFromTimePicker({required BuildContext context}) async =>
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => DateTimePickerBooking(
          modeDateTimePicker: CupertinoDatePickerMode.time,
          onPressCancel: () => Navigator.of(context).pop(),
          onPressDone: () {
            Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {}));
            Navigator.of(context).pop();
          },
          onDateTimeChanged: (picked) => fromTime = picked,
          minuteInterval: 15,
          initialDateTime: fromTime,
        ),
      ).then(
        (value) => showProgressIndicator(context),
      );

  Future<void> showToTimePicker({required BuildContext context}) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (context) => DateTimePickerBooking(
        modeDateTimePicker: CupertinoDatePickerMode.time,
        onPressCancel: () => Navigator.of(context).pop(),
        onPressDone: () {
          Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {}));
          Navigator.of(context).pop();
        },
        onDateTimeChanged: (picked) => toTime = picked,
        minuteInterval: 15,
        initialDateTime: toTime,
      ),
    ).then(
      (value) => showProgressIndicator(context),
    );
  }

  String getOrderbleTypeBooking(BuildContext context) {
    var state = BlocProvider.of<NewBookingReviewBloc>(context).state;
    if (state.equipmentItem != null) {
      return 'Equipment';
    } else {
      return 'Room';
    }
  }
}
