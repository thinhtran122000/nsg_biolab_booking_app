import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

// super small
TextStyle superSmallBlackTextStyle(Color? color) => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 12,
      color: color,
    );
// Small
TextStyle get smallBlackTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 14,
      color: blackColor,
    );
TextStyle get smallBlackBlurTextStyle => TextStyle(
      height: 1.5,
      fontSize: 14,
      fontFamily: FontsPath.futuraMediumBT.assetName,
      package: 'shared_ui',
      color: blackColor.withOpacity(0.7),
    );
TextStyle get smallBlackSuperBlurTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 14,
      color: blackColor.withOpacity(0.5),
    );

TextStyle get smallGreenTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 14,
      color: greenColor,
    );

TextStyle get smallRedTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 14,
      color: redColor,
    );

TextStyle get smallGreyTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 14,
      color: greyColor,
    );

TextStyle get smallBlueTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 14,
      color: lightBlueColor,
    );

// Medium
TextStyle get mediumBlackBlurTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 15,
      color: blackColor.withOpacity(0.7),
    );

TextStyle get mediumBlackTextStyle => TextStyle(
      fontSize: 15,
      package: 'shared_ui',
      fontFamily: FontsPath.futuraHeavyBT.assetName,
      color: blackColor,
    );
// Large
TextStyle get largeBlackTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: blackColor,
    );

TextStyle get largeBlackBlurTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: blackColor.withOpacity(0.7),
    );
TextStyle get largeBlackSuperBlurTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      color: blackColor.withOpacity(0.5),
      fontSize: 16,
    );
TextStyle get largeBlackLessBlurTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: blackColor.withOpacity(0.8),
    );

TextStyle get largeWhiteTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: whiteColor,
    );

TextStyle get largeRedTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: whiteColor,
    );

TextStyle get largeGreyTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: greyColor,
    );

TextStyle get largeGreenTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: greenColor,
    );
TextStyle get largeGreenBlurTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: greenColor.withOpacity(0.7),
    );
TextStyle get largeLightBlueTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: blueColor,
    );
// Super large
// Medim
TextStyle get superLargeBlackMediumFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 18,
      color: blackColor,
    );
TextStyle get superLargeGreyMediumFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 18,
      color: greyColor,
    );
TextStyle get superLargeGreenMediumFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 18,
      color: greenColor,
    );

TextStyle get superLargeGreenBlurMediumFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 18,
      color: greenColor.withOpacity(0.7),
    );
TextStyle get superLargeRedMediumFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 18,
      color: greenColor,
    );

TextStyle get superLargeBlackBlurMediumFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 18,
      color: blackColor.withOpacity(0.7),
    );
TextStyle get superLargeBlackSuperBlurMediumFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 18,
      color: blackColor.withOpacity(0.4),
    );
TextStyle get superLargeGreenMediumTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 18,
      color: greenColor.withOpacity(0.7),
    );
// Heavy
TextStyle get superLargeBlackBlurHeavyFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraHeavyBT.assetName,
      fontSize: 18,
      color: blackColor.withOpacity(0.7),
    );
TextStyle get superLargeBlackHeavyFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraHeavyBT.assetName,
      fontSize: 18,
      color: blackColor,
    );

TextStyle get superLargeHeavyFuturaTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraHeavyBT.assetName,
      fontSize: 18,
    );
// Largest

TextStyle get largestBlackTextStyle => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 20,
      color: blackColor,
    );

TextStyle contentEditBookingTextStyle(Color? color) => TextStyle(
      package: 'shared_ui',
      fontFamily: FontsPath.futuraMediumBT.assetName,
      fontSize: 16,
      color: color?.withOpacity(0.8),
    );
