import 'package:domain/models/sites/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../filter_search_booking/index.dart';
import 'bloc/new_booking_bloc.dart';
import 'view/index.dart';

class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  FilterModel? filterModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewBookingBloc()..add(ChangeTabEvent(indexView: 0)),
      child: BlocBuilder<NewBookingBloc, NewBookingState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<NewBookingBloc>(context);
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: CustomAppBar(
                titleAppBar: 'NSG Biolab',
                visibleAction: state.visibleFilterIcon,
                visibleLeading: true,
                onPressLeading: () => Navigator.of(context).pop(),
                onPressAction: () async {
                  filterModel = await Navigator.of(context).push(
                    HorizontalNavigatorRoute<FilterModel>(
                      begin: const Offset(1, 0),
                      page: FilterSearchBookingScreen(filterModel: filterModel),
                    ),
                  );
                  bloc.add(SetDataFilter(resultsFilter: filterModel));
                },
                iconAction: Image.asset(
                  ImagePath.filterIcon.assetName,
                  width: 18,
                  height: 19,
                ),
              ),
              body: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    SizedBox(
                      child: Theme(
                        data: ThemeData(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: TabBar(
                          onTap: (value) {
                            bloc.add(ChangeTabEvent(indexView: value));
                          },
                          indicatorColor: greenColor,
                          labelColor: greenColor,
                          unselectedLabelColor: Colors.grey,
                          indicatorWeight: 3,
                          tabs: [
                            CustomTab(
                              data: 'Equipments',
                              textStyle: superLargeHeavyFuturaTextStyle,
                            ),
                            CustomTab(
                              data: 'Meeting Room',
                              textStyle: superLargeHeavyFuturaTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: state.indexView,
                        children: [
                          NewEquipmentView(
                            filterModel: state.resultFilter,
                          ),
                          const NewMeetingRoomView(),
                        ],
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
}
