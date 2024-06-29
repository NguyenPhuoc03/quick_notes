import 'package:flutter/material.dart';
import 'package:quick_notes/styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeControllers extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  late SharedPreferences storage;

  ThemeData currentTheme() {
    //return _isDark ? MyTheme.darkTheme : MyTheme.lightTheme;
    return _isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

//change status in switch
  void toggleSwitch() {
    _isDark = !isDark;
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }

  void init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark") ?? false;
    notifyListeners();
  }

}
