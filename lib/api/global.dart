import 'dart:convert';

import 'package:enis/api/data/student_data.dart';
import 'package:enis/api/data/user_data.dart';
import 'package:enis/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static UserData userData;
  static SharedPreferences prefs;
  static List<LoadedStudentData> students;
  static ThemeMode themeMode;
  static EnisAppState appState;

  static Future setTheme(String value) async {
    if (value == 'light') {
      themeMode = ThemeMode.light;
    } else if (value == 'dark') {
      themeMode = ThemeMode.dark;
    } else if (value == 'system') {
      themeMode = ThemeMode.system;
    }

    prefs.setString('theme', value);
    appState.updateTheme(true);
  }

  static String getSelectedThemeString() {
    if (themeMode == ThemeMode.light) return 'light';
    if (themeMode == ThemeMode.dark) return 'dark';
    if (themeMode == ThemeMode.system) return 'system';
    
    return 'system';
  }

  static Future<void> load() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();

    final userDataString = prefs.getString('userData');
    final themeString = prefs.getString('theme');
    setTheme(themeString ?? 'system');

    if (userDataString == null) return;

    userData = UserData.fromJson(json.decode(userDataString));
  }

  static Future<void> save() async {
    prefs.setString('userData', json.encode(userData.toJson()));
  }

  static Future<void> clear() async {
    prefs.setString('userData', null);
  }
}
