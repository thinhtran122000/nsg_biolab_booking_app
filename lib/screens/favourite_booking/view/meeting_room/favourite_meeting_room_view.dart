import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsg_biolab_booking_app/blocs/bloc/global_bloc.dart';
import 'package:nsg_biolab_booking_app/screens/favourite_booking/favourite_booking_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../../../component/index.dart';
import '../../../../utilities/rest_api_client/index.dart';
import '../../../new_booking_select_time/new_booking_select_time_screen.dart';
import '../../widgets/index.dart';
import 'bloc/meeting_room_bloc.dart';

class FavouriteMeetingRoomView extends StatelessWidget {
  const FavouriteMeetingRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MeetingRoomBloc(FavouriteBookingRepository(restApiClient: RestAPIClient()))..add(FetchDataMeetingRoomEvent()),
      child: BlocListener<MeetingRoomBloc, MeetingRoomState>(
        listener: (context, state) {
          if (state is MeetingRoomSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(
                listMeetingRoom: state.listMeetingRoom,
              ),
            );
          } else if (state is MeetingRoomLikeSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              GlobalToggleLikeMeetingRoom(
                meetingRoomItem: state.favouriteMeetingRoom,
              ),
            );
          }
        },
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            var localBloc = BlocProvider.of<MeetingRoomBloc>(context);
            return Stack(
              children: [
                Center(
                  child: BackgroundEmptyDataFavourite(
                    visibility: state.listMeetingRoom.isNotEmpty ? false : true,
                    notificationData: 'You have no favourite Meeting Room',
                    startMessageRequiredData: 'Click the',
                    endMessageRequiredData: 'to save to My Favourites',
                  ),
                ),
                Visibility(
                  visible: true,
                  child: SmartRefresher(
                    enablePullUp: checkList(context),
                    enablePullDown: true,
                    header: MaterialClassicHeader(color: greenColor),
                    footer: const LoadMoreWidget(),
                    onLoading: () => context.read<MeetingRoomBloc>().add(LoadMoreMeetingRoomEvent()),
                    onRefresh: () => context.read<MeetingRoomBloc>().add(FetchDataMeetingRoomEvent()),
                    controller: localBloc.meetingRoomRefreshController,
                    child: SingleChildScrollView(
                      primary: true,
                      child: SizedBox(
                        child: ListView.separated(
                          primary: true,
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: itemBuilder,
                          separatorBuilder: separatorBuilder,
                          itemCount: state.listMeetingRoom.length,
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
    );
  }

  bool checkList(BuildContext context) {
    var state = BlocProvider.of<GlobalBloc>(context).state;
    var listMeetingRoom = state.listMeetingRoom;
    if (listMeetingRoom.isNotEmpty) {
      if (listMeetingRoom.length <= 3) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Widget itemBuilder(BuildContext context, int index) {
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var localBloc = BlocProvider.of<MeetingRoomBloc>(context);
    var itemListMeetingRoom = globalBloc.state.listMeetingRoom[index];
    String nameMeetingRoom = itemListMeetingRoom.name ?? '';
    Color? colorTagMeetingRoom = Color(int.parse('0xff${itemListMeetingRoom.site?.colorTag?.replaceAll('#', '')}'));
    String? levelMeetingRoom = itemListMeetingRoom.site?.level.toString();
    String? siteNameMeetingRoom = itemListMeetingRoom.site?.name;
    return ItemMeetingRoomWidget(
      nameMeetingRoomData: nameMeetingRoom,
      colorTagMeetingRoom: colorTagMeetingRoom,
      levelAndSiteNameMeetingRoomData: 'Level $levelMeetingRoom, $siteNameMeetingRoom',
      iconLike: Icons.favorite,
      onTapLike: localBloc.canTapLike == true
          ? () {
              showProgressIndicator(context);
              localBloc.add(ToggleLikeMeetingRoomEvent(
                favouriteMeetingRoom: itemListMeetingRoom,
              ));
            }
          : null,
      onTapItem: () => Navigator.push(
        context,
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
