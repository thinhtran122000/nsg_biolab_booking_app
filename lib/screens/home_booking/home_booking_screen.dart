import 'package:codebase/blocs/bloc/global_bloc.dart';
import 'package:codebase/screens/details_meeting_room_booking/details_meeting_room_booking_screen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../component/index.dart';
import '../../utilities/index.dart';
import '../../utilities/rest_api_client/index.dart';
import '../details_equipment_booking/details_equipment_booking_screen.dart';
import 'bloc/home_booking_bloc.dart';
import 'index.dart';
import 'widgets/index.dart';

class HomeBookingScreen extends StatelessWidget {
  const HomeBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBookingBloc(
        HomeBookingRepository(
          restApiClient: RestAPIClient(),
        ),
      )..add(FetchDataHomeBookingEvent()),
      child: BlocListener<HomeBookingBloc, HomeBookingState>(
        listener: (context, state) {
          if (state is HomeBookingSucess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(
                listOngoingBooking: state.listOngoingBooking,
                listUpcomingBooking: state.listUpcomingBooking,
              ),
            );
          }
        },
        child: Scaffold(
          appBar: const CustomAppBar(
            titleAppBar: 'NSG Biolab',
          ),
          body: BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, state) {
              var localBloc = BlocProvider.of<HomeBookingBloc>(context);
              var listOngoingBooking = state.listOngoingBooking;
              var listUpcomingBooking = state.listUpcomingBooking;
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: NotificationListener(
                          onNotification: (notification) {
                            if (notification is ScrollNotification) {
                              localBloc.add(ShowButtonScrollTopEvent(
                                listOngoingBooking: state.listOngoingBooking,
                                listUpcomingBooking: state.listUpcomingBooking,
                              ));
                            }
                            return true;
                          },
                          child: SmartRefresher(
                            scrollController: localBloc.homeScrollController,
                            enablePullUp: checkList(context),
                            enablePullDown: true,
                            header: MaterialClassicHeader(color: greenColor),
                            footer: const LoadMoreWidget(),
                            onLoading: () {
                              localBloc.add(LoadMoreUpcomingBookingEvent());
                            },
                            onRefresh: () {
                              localBloc.add(FetchDataHomeBookingEvent());
                            },
                            controller: localBloc.refreshController,
                            child: Stack(
                              children: [
                                BackGroundWidget(
                                  visibleTitle: true,
                                  visibilityBackGround: (listUpcomingBooking.isNotEmpty ||
                                          listOngoingBooking.isNotEmpty)
                                      ? false
                                      : true,
                                  notificationData: 'You have no active bookings',
                                  startMessageRequiredData: 'Click the',
                                  endMessageRequiredData: 'below to add new bookings',
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 22),
                                    Visibility(
                                      visible: listOngoingBooking.isNotEmpty ? true : false,
                                      child: const TitleListWidgetHome(
                                        titleListBooking: 'My Ongoing Bookings',
                                      ),
                                    ),
                                    Visibility(
                                      visible: listOngoingBooking.isNotEmpty ? true : false,
                                      child: SizedBox(
                                        child: ListView.separated(
                                          padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
                                          shrinkWrap: true,
                                          controller: ScrollController(),
                                          itemBuilder: itemBuilderOngoing,
                                          separatorBuilder: separatorBuilder,
                                          itemCount: listOngoingBooking.length,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: listUpcomingBooking.isNotEmpty ? true : false,
                                      child: const TitleListWidgetHome(
                                        titleListBooking: 'My Upcoming Bookings',
                                      ),
                                    ),
                                    SizedBox(
                                      child: ListView.separated(
                                        padding: EdgeInsets.fromLTRB(
                                          24,
                                          22,
                                          24,
                                          listUpcomingBooking.length == 1 ? 30 : 0,
                                        ),
                                        shrinkWrap: true,
                                        controller: ScrollController(),
                                        itemBuilder: itemBuilderUpcoming,
                                        separatorBuilder: separatorBuilder,
                                        itemCount: listUpcomingBooking.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                  Positioned(
                    top: 20,
                    left: 140,
                    child: Visibility(
                      visible: localBloc.visibleButton,
                      child: GestureDetector(
                        onTap: () => localBloc.add(ScrollTopEvent(
                          listOngoingBooking: state.listOngoingBooking,
                          listUpcomingBooking: state.listUpcomingBooking,
                        )),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(blurRadius: 1),
                            ],
                            shape: BoxShape.circle,
                            color: whiteColor,
                          ),
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: Icon(
                              Icons.double_arrow_rounded,
                              color: greenColor,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget itemBuilderOngoing(BuildContext context, int index) {
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListOngoingBooking = globalBloc.state.listOngoingBooking[index];
    String? levelOngoing = itemListOngoingBooking.orderable?.site?.level.toString();
    String? siteNameOngoing = itemListOngoingBooking.orderable?.site?.name;
    String orderableNameOngoing = itemListOngoingBooking.orderable?.name ?? '';
    Color? colorTagOngoing = Color(
        int.parse('0xff${itemListOngoingBooking.orderable?.site?.colorTag?.replaceAll('#', '')}'));
    String startDateOngoing =
        Utilities().dateFormat(itemListOngoingBooking.startDate ?? DateTime.now(), 'MMM d (EEE)');
    String endDateOngoing =
        Utilities().dateFormat(itemListOngoingBooking.endDate ?? DateTime.now(), 'MMM d (EEE)');
    String startTimeOngoing = Utilities()
        .timeFormat(Utilities().convertDoubleToTime(itemListOngoingBooking.startTime ?? 0));
    String endTimeOngoing = Utilities()
        .timeFormat(Utilities().convertDoubleToTime(itemListOngoingBooking.endTime ?? 0));
    return ItemBookingWidget(
      orderableNameData: orderableNameOngoing,
      colorTagBooking: colorTagOngoing,
      levelAndSiteNameData: 'Level $levelOngoing, $siteNameOngoing',
      dateBookingData: '$startDateOngoing - $endDateOngoing',
      timeBookingData: '$startTimeOngoing - $endTimeOngoing',
      onTapItem: () => checkTypeBooking(itemListOngoingBooking.orderableType ?? '')
          ? goToDetailsEquipmentScreen(
              context: context,
              ongoingBooking: itemListOngoingBooking,
              checkBooking: true,
            )
          : goToDetailsMeetingRoomScreen(
              context: context,
              ongoingBooking: itemListOngoingBooking,
              checkBooking: true,
            ),
    );
  }

  Widget itemBuilderUpcoming(BuildContext context, int index) {
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListUpcomingBooking = globalBloc.state.listUpcomingBooking[index];
    String? levelUpcoming = itemListUpcomingBooking.orderable?.site?.level.toString();
    String? siteNameUpcoming = itemListUpcomingBooking.orderable?.site?.name;
    String orderableNameUpcoming = itemListUpcomingBooking.orderable?.name ?? '';
    Color? colorTagUpcoming = Color(
        int.parse('0xff${itemListUpcomingBooking.orderable?.site?.colorTag?.replaceAll('#', '')}'));
    String startDateUpcoming =
        Utilities().dateFormat(itemListUpcomingBooking.startDate ?? DateTime.now(), 'MMM d (EEE)');
    String endDateUpcoming =
        Utilities().dateFormat(itemListUpcomingBooking.endDate ?? DateTime.now(), 'MMM d (EEE)');
    String startTimeUpcoming = Utilities()
        .timeFormat(Utilities().convertDoubleToTime(itemListUpcomingBooking.startTime ?? 0));
    String endTimeUpcoming = Utilities()
        .timeFormat(Utilities().convertDoubleToTime(itemListUpcomingBooking.endTime ?? 0));
    return ItemBookingWidget(
      orderableNameData: orderableNameUpcoming,
      colorTagBooking: colorTagUpcoming,
      levelAndSiteNameData: 'Level $levelUpcoming, $siteNameUpcoming',
      dateBookingData: '$startDateUpcoming - $endDateUpcoming',
      timeBookingData: '$startTimeUpcoming - $endTimeUpcoming',
      onTapItem: () => checkTypeBooking(itemListUpcomingBooking.orderableType ?? '')
          ? goToDetailsEquipmentScreen(
              context: context,
              upcomingBooking: itemListUpcomingBooking,
              checkBooking: false,
            )
          : goToDetailsMeetingRoomScreen(
              context: context,
              upcomingBooking: itemListUpcomingBooking,
              checkBooking: false,
            ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(
        height: 15,
      );

  bool checkTypeBooking(String orderableType) {
    if (orderableType.contains('EquipmentItem')) {
      return true;
    } else if (orderableType.contains('MeetingRoom')) {
      return false;
    } else {
      return false;
    }
  }

  bool checkList(BuildContext context) {
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var listOngoingBooking = globalBloc.state.listOngoingBooking;
    var listUpcomingBooking = globalBloc.state.listUpcomingBooking;
    if (listUpcomingBooking.isNotEmpty) {
      if (listUpcomingBooking.length <= 1) {
        return false;
      } else {
        return true;
      }
    } else if (listOngoingBooking.isNotEmpty) {
      if (listOngoingBooking.length <= 2) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  goToDetailsEquipmentScreen({
    OngoingBooking? ongoingBooking,
    UpcomingBooking? upcomingBooking,
    required bool checkBooking,
    required BuildContext context,
  }) =>
      Navigator.of(context).push(
        HorizontalNavigatorRoute(
          begin: const Offset(1, 0),
          page: DetailsEquipmentBookingScreen(
            ongoingBooking: ongoingBooking,
            upcomingBooking: upcomingBooking,
            checkBooking: checkBooking,
            // check xem booking này thuộc ongoing hay upcoming ở page details Equipment
          ),
        ),
      );

  goToDetailsMeetingRoomScreen({
    OngoingBooking? ongoingBooking,
    UpcomingBooking? upcomingBooking,
    required bool checkBooking,
    required BuildContext context,
  }) =>
      Navigator.of(context).push(
        HorizontalNavigatorRoute(
          begin: const Offset(1, 0),
          page: DetailsMeetingRoomBookingScreen(
            ongoingBooking: ongoingBooking,
            upcomingBooking: upcomingBooking,
            checkBooking: checkBooking,
            // check xem booking này thuộc ongoing hay upcoming ở page details MeetingRoom
          ),
        ),
      );
}
