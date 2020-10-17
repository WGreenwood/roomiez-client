import 'package:flutter/material.dart';
import 'package:roomiez/data/colours.dart' as colours;


ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  accentColor: colours.accent,
  primaryColor: colours.primary,
  accentIconTheme: const IconThemeData(color: colours.white),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    buttonColor: colours.primary,
  ),
);
ThemeData light = new ThemeData(
  brightness: Brightness.light,
  accentColor: colours.accent,
  primaryColor: colours.primary,
  accentIconTheme: const IconThemeData(color: colours.white),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    buttonColor: colours.accent,
  ),
);
