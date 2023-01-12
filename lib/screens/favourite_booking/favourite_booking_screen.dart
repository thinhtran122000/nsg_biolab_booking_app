import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import 'bloc/favourite_booking_bloc.dart';

class FavouriteBookingScreen extends StatelessWidget {
  const FavouriteBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteBookingBloc()..add(ChangeTabEvent(indexView: 0)),
      child: BlocBuilder<FavouriteBookingBloc, FavouriteBookingState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<FavouriteBookingBloc>(context);
          return Scaffold(
            appBar: const CustomAppBar(
              titleAppBar: 'Favourites',
            ),
            body: DefaultTabController(
              length: state.listView.length,
              child: Column(
                children: [
                  SizedBox(
                    child: Theme(
                      data: ThemeData(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: TabBar(
                        onTap: (value) => bloc.add(ChangeTabEvent(indexView: value)),
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
                      children: state.listView,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
