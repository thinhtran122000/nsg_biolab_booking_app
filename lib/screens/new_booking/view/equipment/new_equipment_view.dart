import 'package:domain/models/sites/filter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsg_biolab_booking_app/screens/new_booking/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../../../blocs/bloc/global_bloc.dart';
import '../../../../component/index.dart';
import '../../../../utilities/rest_api_client/index.dart';
import '../../../new_booking_select_time/new_booking_select_time_screen.dart';
import '../../widgets/index.dart';
import 'bloc/equipment_bloc.dart';

class NewEquipmentView extends StatelessWidget {
  final FilterModel? filterModel;
  const NewEquipmentView({
    Key? key,
    this.filterModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EquipmentBloc(NewBookingRepository(restApiClient: RestAPIClient()))
        ..add(FetchDataEquipmentEvent(levels: filterModel?.levels, sites: filterModel?.sites)),
      child: BlocListener<EquipmentBloc, EquipmentState>(
        listener: (context, state) {
          if (state is EquipmentSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(listNewEquipment: state.listEquipment),
            );
          } else if (state is EquipmentLikeSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              GlobalToggleLikeEquipment(equipmentItem: state.equipmentItem),
            );
          }
        },
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            var localBloc = BlocProvider.of<EquipmentBloc>(context);
            if (state is EquipmentInitial) {
              return const LoadingPageWidget();
            }
            return Stack(
              children: [
                Column(
                  children: [
                    TextFieldSearchNewBooking(
                      controller: localBloc.equipmentTextEditingController,
                      onChanged: (value) => Future.delayed(
                        const Duration(milliseconds: 300),
                        () => localBloc.add(FetchDataEquipmentEvent(
                          levels: filterModel?.levels,
                          sites: filterModel?.sites,
                        )),
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
                          scrollController: localBloc.equipmentScrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          enablePullUp: true,
                          enablePullDown: true,
                          header: MaterialClassicHeader(color: greenColor),
                          footer: const LoadMoreWidget(),
                          onRefresh: () => localBloc
                              .add(FetchDataEquipmentEvent(levels: filterModel?.levels, sites: filterModel?.sites)),
                          onLoading: () => localBloc
                              .add(LoadMoreEquipmentEvent(levels: filterModel?.levels, sites: filterModel?.sites)),
                          controller: localBloc.equipmentRefreshController,
                          child: SizedBox(
                            child: ListView.separated(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                              controller: ScrollController(),
                              shrinkWrap: true,
                              itemBuilder: itemBuilder,
                              separatorBuilder: separatorBuilder,
                              itemCount: state.listNewEquipment.length,
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
    var localBloc = BlocProvider.of<EquipmentBloc>(context);
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListEquipment = globalBloc.state.listNewEquipment[index];
    String nameEquipment = itemListEquipment.name ?? '';
    Color? colorTagEquipment = Color(int.parse('0xff${itemListEquipment.site?.colorTag?.replaceAll('#', '')}'));
    String? levelEquipment = itemListEquipment.site?.level.toString();
    String? siteNameEquipment = itemListEquipment.site?.name;
    return ItemEquipmentWidget(
      nameEquipmentData: nameEquipment,
      levelAndSiteNameEquipmentData: 'Level $levelEquipment, $siteNameEquipment',
      colorTagEquipment: colorTagEquipment,
      iconLike: (itemListEquipment.isLiked ?? true) ? Icons.favorite : Icons.favorite_outline,
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
                ToggleLikeEquipmentEvent(equipmentItem: itemListEquipment),
              );
            }
          : null,
      onTapInfo: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 15,
    );
  }

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
