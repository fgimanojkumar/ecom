import 'package:flutter/material.dart';

class AppPadding {
  AppPadding._internal();
  static final AppPadding _instance = AppPadding._internal();
  factory AppPadding() {
    return _instance;
  }

  final formInputPadding = const EdgeInsets.only(
    left: 20.0,
    right: 20.0,
    bottom: 10,
    top: 10,
  );

  final inputContentPadding = const EdgeInsets.only(
    left: 10,
    right: 10,
    top: 10,
    bottom: 10,
  );

  final inputPadding = const EdgeInsets.only(
    left: 30.0,
    right: 30.0,
  );

  final EdgeInsets cardContainerPadding = const EdgeInsets.all(15.0);

  final EdgeInsets pagePadding = const EdgeInsets.symmetric(horizontal: 16.0);

  // Standard constants — use these for consistent horizontal page padding
  static const double hPad = 16.0;
  static const EdgeInsets pageH = EdgeInsets.symmetric(horizontal: hPad);
  static const EdgeInsets pageScroll =
      EdgeInsets.symmetric(horizontal: hPad, vertical: 16.0);

  final EdgeInsets tableCellPadding = const EdgeInsets.only(
    top: 8.0,
    bottom: 8.0,
    right: 8.0,
  );

  final webFormInputPadding = const EdgeInsets.only(
    left: 10.0,
    right: 10.0,
    bottom: 10,
    top: 10,
  );
}
