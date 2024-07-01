import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  static ThemeData lightTheme = ThemeData(
      primaryColor: Colors.grey.shade100,
      brightness: Brightness.light,
      primaryColorDark: Colors.white);
}

class AppTheme {
  AppTheme._();

//light
  static Color _lightPrimaryColor = Colors.grey.shade100;
  static Color _lightSecondaryColor = Colors.grey.shade200;
  static Color _lightThirdColor = Colors.blue.shade200;
  static Color _lightContainerColor = Colors.grey.shade400;
  static const Color _lightOnPrimaryColor = Colors.black;
  static Color _lightIconFirstColor = Colors.lightBlue.shade400;
  static Color _lightIconSecondColor = Colors.blue.shade100;

  static final TextTheme _lightTextTheme = TextTheme(
    headlineLarge: const TextStyle(
        color: _lightOnPrimaryColor,
        fontFamily: "Roboto",
        fontWeight: FontWeight.bold,
        fontSize: 21),
    displaySmall: const TextStyle(
      color: _lightOnPrimaryColor,
      fontSize: 16.0,
    ),
    labelSmall: const TextStyle(
        fontSize: 14, color: _lightOnPrimaryColor, fontFamily: "Roboto"),
    titleLarge: GoogleFonts.roboto(
        fontSize: 18.0,
        color: _lightOnPrimaryColor,
        fontWeight: FontWeight.bold), //mainTitle
    titleMedium: GoogleFonts.roboto(
        fontSize: 16.0,
        color: _lightOnPrimaryColor,
        fontWeight: FontWeight.normal), //mainContent
    titleSmall: GoogleFonts.roboto(
        fontSize: 13.0,
        color: _lightOnPrimaryColor,
        fontWeight: FontWeight.w500), //dateTitle
    bodyMedium: GoogleFonts.nunito(
      fontSize: 16.0,
      color: _lightOnPrimaryColor,
    ),
    bodySmall: const TextStyle(
        fontSize: 12, color: _lightOnPrimaryColor, fontFamily: "Roboto"),
  );

//dark
  static final TextTheme _darkTextTheme = TextTheme(
    headlineLarge: const TextStyle(
        color: _darkOnPrimaryColor,
        fontFamily: "Roboto",
        fontWeight: FontWeight.bold,
        fontSize: 21),
    displaySmall: const TextStyle(
      color: _darkTextColor,
      fontSize: 16.0,
    ),
    labelSmall: const TextStyle(
        fontSize: 14, color: _darkOnPrimaryColor, fontFamily: "Roboto"),
    titleLarge: GoogleFonts.roboto(
        fontSize: 18.0,
        color: _darkTextColor,
        fontWeight: FontWeight.bold), //mainTitle
    titleMedium: GoogleFonts.roboto(
        fontSize: 16.0,
        color: _darkTextColor,
        fontWeight: FontWeight.normal), //mainContent
    titleSmall: GoogleFonts.roboto(
        fontSize: 13.0,
        color: _darkTextColor,
        fontWeight: FontWeight.w500), //dateTitle
    bodyMedium: GoogleFonts.nunito(
        fontSize: 16.0,
        color: _darkOnPrimaryColor,
        fontWeight: FontWeight.w500),
    bodySmall: const TextStyle(
        fontSize: 12, color: _darkOnPrimaryColor, fontFamily: "Roboto"),
  );
  static final _darkPrimaryColor = Colors.grey.shade600;
  static final Color _darkSecondaryColor = Colors.grey.shade700;
  static const Color _darkThirdColor = Colors.deepPurple;
  static const Color _darkContainerColor = Colors.transparent;
  static const Color _darkOnPrimaryColor = Colors.white;
  static Color _darkIconFirstColor = Colors.deepPurple.shade400;
  static Color _darkIconSecondColor = Colors.deepPurple.shade50;
  static Color _darkIconThirdColor = Colors.yellow.shade400;
  static const Color _darkTextColor = Colors.black;

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: _lightTextTheme.headlineLarge,
      centerTitle: true,
      backgroundColor: _lightSecondaryColor,
      iconTheme: const IconThemeData(color: _lightOnPrimaryColor),
      actionsIconTheme: const IconThemeData(color: _lightOnPrimaryColor),
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
      onSecondaryContainer: _lightContainerColor,
      onSurface: _lightOnPrimaryColor,
      background: _lightPrimaryColor,
      onTertiary: _lightOnPrimaryColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: _lightPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    iconTheme: IconThemeData(
      color: _lightOnPrimaryColor,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: _lightThirdColor),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: _lightTextTheme.displaySmall,
    ),
    textTheme: _lightTextTheme,
    switchTheme: SwitchThemeData(
      //! Use if-else to avoid dark mode or light mode errors
      //phan hinh tron
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.selected)) {
          return _lightIconFirstColor; // Color when switch is off in light theme
        }
        return _darkIconFirstColor; //Color when switch is on in light theme
      }),
      //dai duong của switch, o duoi nut
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.selected)) {
          return _lightIconSecondColor; // Track color when off
        }
        return _darkIconSecondColor; // Track color when on
      }),
      //vien
      trackOutlineColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.selected)) {
          return _lightIconFirstColor; // Outline color when off
        }
        return _darkIconFirstColor; // Outline color when on
      }),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: _darkTextTheme.headlineLarge,
      backgroundColor: _darkSecondaryColor,
      iconTheme: const IconThemeData(color: _darkOnPrimaryColor),
      centerTitle: true,
      actionsIconTheme: const IconThemeData(color: _darkOnPrimaryColor),
    ),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
      onSecondaryContainer: _darkContainerColor,
      onSurface: _darkOnPrimaryColor, //chu tren man hinh chinh
      background: _darkPrimaryColor,
      onTertiary: _darkIconThirdColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: _darkPrimaryColor),
    iconTheme: const IconThemeData(
      color: _darkOnPrimaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkThirdColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: _darkTextTheme.displaySmall,
      border: InputBorder.none,
    ),
    textTheme: _darkTextTheme,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _darkIconFirstColor;
        }
        return _lightIconFirstColor;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _darkIconSecondColor;
        }
        return _lightIconSecondColor;
      }),
      trackOutlineColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _darkIconFirstColor;
        }
        return _lightIconFirstColor;
      }),
    ),
  );
}
