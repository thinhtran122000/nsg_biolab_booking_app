import 'package:codebase/screens/new_booking/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../../../blocs/bloc/global_bloc.dart';
import '../../../../component/index.dart';
import '../../../../utilities/rest_api_client/api_client.dart';
import '../../../new_booking_select_time/new_booking_select_time_screen.dart';
import '../../widgets/index.dart';
import 'bloc/meeting_room_bloc.dart';

class NewMeetingRoomView extends StatelessWidget {
  const NewMeetingRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MeetingRoomBloc(NewBookingRepository(restApiClient: RestAPIClient()))
        ..add(FetchDataMeetingRoomEvent()),
      child: BlocListener<MeetingRoomBloc, MeetingRoomState>(
        listener: (context, state) {
          if (state is MeetingRoomSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(
                listNewMeetingRoom: state.listMeetingRoom,
              ),
            );
          } else if (state is MeetingRoomLikeSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              GlobalToggleLikeMeetingRoom(
                meetingRoomItem: state.meetingRoomItem,
              ),
            );
          }
        },
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            var localBloc = BlocProvider.of<MeetingRoomBloc>(context);
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFieldSearchNewBooking(
                      controller: localBloc.meetingRoomTextEditingController,
                      onChanged: (value) => Future.delayed(
                        const Duration(milliseconds: 300),
                        () => localBloc.add(FetchDataMeetingRoomEvent()),
                      ),
                    ),
                    Expanded(
                      child: NotificationListener(
                        onNotification: (notification) {
                          if (notification is ScrollNotification) {
                            localBloc.add(ShowButtonScrollTopEvent());
                          }
                          return true;
                        },
                        child: SmartRefresher(
                          scrollController: localBloc.meetingRoomScrollController,
                          enablePullUp: true,
                          enablePullDown: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          header: MaterialClassicHeader(color: greenColor),
                          footer: const LoadMoreWidget(),
                          onRefresh: () => localBloc.add(FetchDataMeetingRoomEvent()),
                          onLoading: () => localBloc.add(LoadMoreMeetingRoomEvent()),
                          controller: localBloc.meetingRoomRefreshController,
                          child: SizedBox(
                            child: ListView.separated(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                              controller: ScrollController(),
                              shrinkWrap: true,
                              itemBuilder: itemBuilder,
                              separatorBuilder: separatorBuilder,
                              itemCount: state.listNewMeetingRoom.length,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: const Alignment(0.9, 1.1),
                  child: Visibility(
                    visible: localBloc.visibleButton,
                    child: CustomFloatingActionButton(
                      heroTagButton: 'equipment',
                      backgroundColor: whiteColor,
                      iconButton: RotatedBox(
                        quarterTurns: -1,
                        child: Icon(
                          Icons.double_arrow_rounded,
                          color: greenColor,
                          size: 40,
                        ),
                      ),
                      onPressed: () => localBloc.add(ScrollTopEvent()),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var localBloc = BlocProvider.of<MeetingRoomBloc>(context);
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListMeetingRoom = globalBloc.state.listNewMeetingRoom[index];
    String nameMeetingRoom = itemListMeetingRoom.name ?? '';
    Color? colorTagMeetingRoom =
        Color(int.parse('0xff${itemListMeetingRoom.site?.colorTag?.replaceAll('#', '')}'));
    String? levelMeetingRoom = itemListMeetingRoom.site?.level.toString();
    String? siteNameMeetingRoom = itemListMeetingRoom.site?.name;
    return ItemMeetingRoomWidget(
      nameMeetingRoomData: nameMeetingRoom,
      colorTagMeetingRoom: colorTagMeetingRoom,
      levelAndSiteNameMeetingRoomData: 'Level $levelMeetingRoom, $siteNameMeetingRoom',
      iconLike: (itemListMeetingRoom.isLiked ?? true) ? Icons.favorite : Icons.favorite_outline,
      onTapLike: localBloc.canTapLike == true
          ? () {
              showProgressIndicator(context);
              localBloc.add(
                ToggleLikeMeetingRoomEvent(
                  meetingRoomItem: itemListMeetingRoom,
                ),
              );
            }
          : null,
      onTapItem: () => Navigator.of(context).push(
        HorizontalNavigatorRoute(
          begin: const Offset(1, 0),
          page: NewBookingSelectTimeScreen(
            meetingRoomItem: itemListMeetingRoom,
          ),
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(
        height: 15,
      );

  showProgressIndicator(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => Center(
        child: CupertinoActivityIndicator(
          radius: 20,
          color: greenColor,
        ),
      ),
    );
    Future.delayed(
      const Duration(milliseconds: 300),
      () => Navigator.of(context).pop(),
    );
  }
}
