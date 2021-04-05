import 'package:ForDev/ui/styles/styles.dart';
import 'package:flutter/material.dart';

ThemeData makeAppTheme(){
  return ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    accentColor: primaryColor,
    backgroundColor: whiteColor,
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: primaryColorDark),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColorLight),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      alignLabelWithHint: true,
    ),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryColor,
      ),
      buttonColor: primaryColor,
      splashColor: primaryColorLight,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}