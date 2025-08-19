import 'package:domain/models/sites/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsg_biolab_booking_app/blocs/bloc/global_bloc.dart';
import 'package:nsg_biolab_booking_app/screens/filter_search_booking/bloc/filter_search_bloc.dart';
import 'package:nsg_biolab_booking_app/screens/filter_search_booking/filter_search_booking_repository.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/rest_api_client/api_client.dart';
import 'widgets/index.dart';

class FilterSearchBookingScreen extends StatefulWidget {
  final FilterModel? filterModel;
  const FilterSearchBookingScreen({
    Key? key,
    this.filterModel,
  }) : super(key: key);

  @override
  State<FilterSearchBookingScreen> createState() => _FilterSearchBookingScreenState();
}

class _FilterSearchBookingScreenState extends State<FilterSearchBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterSearchBloc(FilterSearchBookingRepository(RestAPIClient()))
        ..add(FetchDataFilterEvent(filterModel: widget.filterModel)),
      child: BlocConsumer<FilterSearchBloc, FilterSearchState>(
        listener: (context, state) {
          if (state is FilterSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(UpdateList(
              listNewEquipment: BlocProvider.of<GlobalBloc>(context).state.listNewEquipment,
            ));
            Navigator.of(context).pop(FilterModel(
              levels: state.listFilterLevel,
              sites: state.listFilterSite,
            ));
          }
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<FilterSearchBloc>(context);
          return Scaffold(
            appBar: CustomAppBar(
              titleAppBar: 'Filter',
              visibleAction: true,
              visibleLeading: true,
              onPressLeading: () => widget.filterModel != null
                  ? Navigator.of(context).pop(widget.filterModel)
                  : Navigator.of(context).pop(),
              onPressAction: () => bloc.add(FilterEvent()),
              iconAction: Image.asset(
                ImagePath.checkIcon.assetName,
                width: 20,
                height: 20,
              ),
            ),
            body: SingleChildScrollView(
              controller: ScrollController(),
              physics: const RangeMaintainingScrollPhysics(),
              child: Column(
                children: [
                  TextWidgetTitleListAndResetButton(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 13),
                    dataTitleListFilter: 'Level',
                    dataTextButton: 'Reset',
                    onTapResetButton: () => bloc.add(ResetLevelFilterEvent()),
                  ),
                  SizedBox(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: itemBuilderLevel,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listLevel.length,
                    ),
                  ),
                  TextWidgetTitleListAndResetButton(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 13),
                    dataTitleListFilter: 'Room',
                    dataTextButton: 'Reset',
                    onTapResetButton: () => bloc.add(ResetSiteRoomFilterEvent()),
                  ),
                  SizedBox(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: itemBuilderSiteRoom,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listSite.length,
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilderLevel(BuildContext context, int index) {
    var bloc = BlocProvider.of<FilterSearchBloc>(context);
    var itemLevel = bloc.state.listLevel[index];
    return ItemFilter(
      dataFilter: 'Level $itemLevel',
      isChecked: bloc.isCheckedLevel[index],
      onCheck: () => bloc.add(CheckLevelEvent(
        index: index,
      )),
    );
  }

  Widget itemBuilderSiteRoom(BuildContext context, int index) {
    var bloc = BlocProvider.of<FilterSearchBloc>(context);
    String nameRoom = bloc.state.listSite[index].name ?? '';
    return ItemFilter(
      dataFilter: nameRoom,
      isChecked: bloc.isCheckedRoom[index],
      onCheck: () => bloc.add(CheckRoomEvent(index: index)),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 10,
    );
  }
}
