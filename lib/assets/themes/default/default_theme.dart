import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_weather/assets/themes/default/default_theme_model.dart';

AppTheme lightTheme = const AppTheme(
  name: AvailableTheme.LIGHT,
  brightness: Brightness.light,
  accentSecondaryColor: Color(0xFFFFA68D),
  accentColor: Color(0xFFFF778A),
  primaryColor: Colors.white,
  secondaryColor: Color(0xFFCACACA),
  darkBackgroundColor: Color(0xFFE9E9E9),
  textPrimaryColor: Color(0xFF3F3F3F),
  textSecondaryColor: Color(0xFF6E6E6E),
  textPaleColor: Color(0xFFA3A3A3),
  buttons: AppButtonTheme(
    primaryBackground: Color(0xFF00E6C7),
    secondaryBackground: Color(0xFFD8D8D8),
    disabledBackground: Color(0xFFA3A3A3),
    rejectBackground: Color(0xFFD24949),
    approveBackground: Color(0xFF49D284),
    primarySplashColor: Color(0xFF009682),
    secondarySplashColor: Color(0xFF6E6E6E),
    disabledSplashColor: Color(0xFF6E6E6E),
    rejectSplashColor: Color(0xFFF54F4F),
    approveSplashColor: Color(0xFF00E6C7),
    primaryTextColor: Colors.white,
    secondaryTextColor: Color(0xFF3F3F3F),
    disabledTextColor: Color(0xFF6E6E6E),
    rejectTextColor: Colors.white,
    approveTextColor: Colors.white,
  ),
);

const swatchColorGrade = <int, Color>{
  50: Color.fromRGBO(255, 119, 138, .1),
  100: Color.fromRGBO(255, 119, 138, .2),
  200: Color.fromRGBO(255, 119, 138, .3),
  300: Color.fromRGBO(255, 119, 138, .4),
  400: Color.fromRGBO(255, 119, 138, .5),
  500: Color.fromRGBO(255, 119, 138, .6),
  600: Color.fromRGBO(255, 119, 138, .7),
  700: Color.fromRGBO(255, 119, 138, .8),
  800: Color.fromRGBO(255, 119, 138, .9),
  900: Color.fromRGBO(255, 119, 138, 1),
};

final ThemeData _lightThemeData = ThemeData(
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  primarySwatch: const MaterialColor(0xFFFF778A, swatchColorGrade),
  brightness: Brightness.light,
);

ThemeData lightThemeData = _lightThemeData.copyWith(
  extensions: <ThemeExtension<AppTheme>>[lightTheme],
);
