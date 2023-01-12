import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class BottomSheetWidget extends StatelessWidget {
  final VoidCallback? onTapCamera;
  final VoidCallback? onTapGallery;
  const BottomSheetWidget({
    Key? key,
    this.onTapCamera,
    this.onTapGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 350,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: onTapCamera,
                    // onTap: () {

                    // },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        alignment: Alignment.center,
                        width: 350,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: GestureDetector(
                          child: Text(
                            'Pick Image from camera',
                            style: largeLightBlueTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(color: lightGreyColor),
                  GestureDetector(
                    onTap: onTapGallery,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 350,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Text(
                          'Pick Image from gallery',
                          style: largeLightBlueTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 350,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Cancel',
                      style: smallRedTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
