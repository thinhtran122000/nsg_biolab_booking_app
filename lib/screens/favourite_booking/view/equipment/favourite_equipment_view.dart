import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsg_biolab_booking_app/blocs/bloc/global_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../../../component/index.dart';
import '../../../../utilities/rest_api_client/index.dart';
import '../../../new_booking_select_time/new_booking_select_time_screen.dart';
import '../../index.dart';
import '../../widgets/index.dart';
import 'bloc/equipment_bloc.dart';

class FavouriteEquipmentView extends StatelessWidget {
  const FavouriteEquipmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EquipmentBloc(FavouriteBookingRepository(restApiClient: RestAPIClient()))..add(FetchDataEquipmentEvent()),
      child: BlocListener<EquipmentBloc, EquipmentState>(
        listener: (context, state) {
          log('---${state.runtimeType.toString()}');
          if (state is EquipmentSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(
                listEquipment: state.listEquipment,
              ),
            );
          } else if (state is EquipmentLikeSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              GlobalToggleLikeEquipment(
                equipmentItem: state.favouriteEquipment,
              ),
            );
          }
        },
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            var localBloc = BlocProvider.of<EquipmentBloc>(context);
            return Stack(
              children: [
                BackgroundEmptyDataFavourite(
                  visibility: state.listEquipment.isNotEmpty ? false : true,
                  notificationData: 'You have no favourite Equipment',
                  startMessageRequiredData: 'Click the',
                  endMessageRequiredData: 'to save to My Favourites',
                ),
                SmartRefresher(
                  enablePullUp: checkList(context),
                  enablePullDown: true,
                  header: MaterialClassicHeader(color: greenColor),
                  footer: const LoadMoreWidget(),
                  onLoading: () => localBloc.add(LoadMoreEquipmentEvent()),
                  onRefresh: () => localBloc.add(FetchDataEquipmentEvent()),
                  controller: localBloc.equipmentRefreshController,
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
                        itemCount: state.listEquipment.length,
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
    var listEquipment = state.listEquipment;
    if (listEquipment.isNotEmpty) {
      if (listEquipment.length <= 2) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Widget itemBuilder(BuildContext context, int index) {
    var localBloc = BlocProvider.of<EquipmentBloc>(context);
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListEquipment = globalBloc.state.listEquipment[index];
    String nameEquipment = itemListEquipment.name ?? '';
    Color? colorTagEquipment = Color(int.parse('0xff${itemListEquipment.site?.colorTag?.replaceAll('#', '')}'));
    String? levelEquipment = itemListEquipment.site?.level.toString();
    String? siteNameEquipment = itemListEquipment.site?.name;
    return ItemEquipmentWidget(
      nameEquipmentData: nameEquipment,
      levelAndSiteNameEquipmentData: 'Level $levelEquipment, $siteNameEquipment',
      colorTagEquipment: colorTagEquipment,
      iconLike: Icons.favorite,
      onTapItem: () => Navigator.push(
        context,
        HorizontalNavigatorRoute(
          begin: const Offset(1, 0),
          page: NewBookingSelectTimeScreen(
            equipmentItem: itemListEquipment,
          ),
        ),
      ),
      onTapLike: localBloc.canTapLike == true
          ? () {
              showProgressIndicator(context);
              localBloc.add(
                ToggleLikeEquipmentEvent(
                  favouriteEquipment: itemListEquipment,
                ),
              );
            }
          : null,
      onTapInfo: () {},
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
