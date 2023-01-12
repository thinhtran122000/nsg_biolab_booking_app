import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/shared_ui.dart';

class LoadMoreWidget extends StatelessWidget {
  const LoadMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const SizedBox();
        } else if (mode == LoadStatus.loading) {
          body = Padding(
            padding: const EdgeInsets.all(20),
            child: CupertinoActivityIndicator(
              color: greenColor,
            ),
          );
        } else if (mode == LoadStatus.failed) {
          body = const SizedBox();
        } else if (mode == LoadStatus.canLoading) {
          body = const SizedBox();
        } else if (mode == LoadStatus.noMore) {
          body = const Text('No data');
        } else {
          body = const SizedBox();
        }
        return SizedBox(
          height: 60,
          child: Center(child: body),
        );
      },
    );
  }
}
