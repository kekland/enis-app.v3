import 'dart:convert';

import 'package:enis/api/data/student_data.dart';
import 'package:enis/api/data/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static UserData userData;
  static SharedPreferences prefs;
  static String sessionId;
  static List<LoadedStudentData> students;

  static Future<void> load() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();

    final userDataString = prefs.getString('userData');

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
