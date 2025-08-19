

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../new_booking/index.dart';
import 'bloc/navigation_bloc.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc()..add(NavigateScreenEvent(indexPage: 0)),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<NavigationBloc>(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: state.listPage[bloc.pageIndex],
            bottomSheet: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0.5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 4,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Divider(
                            color: bloc.pageIndex == 0 ? greenColor : whiteColor,
                            thickness: 4,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Divider(
                            color: bloc.pageIndex == 1 ? redColor : whiteColor,
                            thickness: 4,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Divider(
                            color: bloc.pageIndex == 2 ? orangeColor : whiteColor,
                            thickness: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => bloc.add(NavigateScreenEvent(indexPage: 0)),
                          child: SizedBox(
                            height: 64,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  bloc.pageIndex == 0
                                      ? ImagePath.homeIconFilled.assetName
                                      : ImagePath.homeIconOutline.assetName,
                                  width: 20,
                                  height: 18.59,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 6),
                                  child: Text(
                                    'Home',
                                    style: superSmallBlackTextStyle(
                                      bloc.pageIndex == 0
                                          ? greenColor
                                          : blackColor.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => bloc.add(NavigateScreenEvent(indexPage: 1)),
                          child: SizedBox(
                            height: 64,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  bloc.pageIndex == 1
                                      ? ImagePath.favoriteIconFilled.assetName
                                      : ImagePath.favoriteIconOutline.assetName,
                                  width: 20,
                                  height: 18.59,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 6),
                                  child: Text(
                                    'Favourites',
                                    style: superSmallBlackTextStyle(
                                      bloc.pageIndex == 1 ? redColor : blackColor.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => bloc.add(NavigateScreenEvent(indexPage: 2)),
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            height: 64,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  bloc.pageIndex == 2
                                      ? ImagePath.profileIconFilled.assetName
                                      : ImagePath.profileIconOutline.assetName,
                                  width: 20,
                                  height: 18.59,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 6),
                                  child: Text(
                                    'Profile',
                                    style: superSmallBlackTextStyle(
                                      bloc.pageIndex == 2
                                          ? orangeColor
                                          : blackColor.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: Visibility(
              visible: bloc.pageIndex == 2 ? false : true,
              child: CustomFloatingActionButton(
                heroTagButton: 'newBooking',
                backgroundColor: greenColor,
                iconButton: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                onPressed: () => Navigator.of(context).push(
                  HorizontalNavigatorRoute(
                    begin: const Offset(1, 0),
                    page: const NewBookingScreen(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
