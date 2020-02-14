import 'package:flutter/material.dart';

const Color kBackgroundColor = Color(0xff2d2d2d);
const Color kBackgroundDarker = Color(0xff212121);
const Color kBackgroundDarker2 = Color(0xff171717);
const Color kBrightBlue = Color(0xff4fc3f7);
const Color kBrickRed = Color(0xffB03C08);
const Color kBrickRedDarker = Color(0xff9c3406);
const Color kOffWhite = Colors.white70;

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontFamily: 'Roboto',
            fontSize: 24,
        fontWeight: FontWeight.w600,
        color: kBrightBlue,
      ),
      headline2: base.headline2.copyWith(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: kOffWhite,
      ),
        headline3: base.headline3.copyWith(
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: kBrightBlue,
        ),
    );
  }

  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    canvasColor: kBackgroundDarker,
  );
}