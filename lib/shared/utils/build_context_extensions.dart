import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  Size get screenSize => MediaQuery.of(this).size;
  void unFocusedKeyboard() => FocusScope.of(this).unfocus();
  void focusedKeyboard() => FocusScope.of(this).requestFocus(FocusNode());
}
