import 'dart:convert';

import 'package:enis/api/data/schedule_data.dart';
import 'package:enis/api/data/user_data.dart';
import 'package:http/http.dart' as http;

import 'global.dart';

class Api {
  static Map<String, String> getCookieHeaders() {
    final userToken = Global.sessionId;

    return {'cookie': 'UserSessionKey=$userToken'};
  }

  static Future signIn({UserData userData}) async {
    final response = await http.post('${userData.schoolUrl}/root/Account/LogOn',
        body: {
          "login": userData.username,
          "password": userData.password,
          "captchaInput": ""
        });
    final body = json.decode(response.body);

    if (body['success']) {
      Global.userData = userData;
      await Global.save();
    } else
      throw Exception(body['message']);
  }

  static Future getSchedule() async {
    final userData = Global.userData;

    final response = await http.post(
      '${userData.schoolUrl}/MySchedule/GetMySchedule',
      headers: getCookieHeaders(),
    );

    final body = json.decode(response.body);

    if (body['success']) {
      return ScheduleData.fromJson(body['data']);
    } else
      throw Exception(body['message']);
  }
  
  static Future getPeriods() async {
    final userData = Global.userData;

    final response = await http.post(
      '${userData.schoolUrl}/JceDiary/GetCurrentPeriods',
      headers: getCookieHeaders(),
    );

    final body = json.decode(response.body);

    if (body['success']) {
      return ScheduleData.fromJson(body['data']);
    } else
      throw Exception(body['message']);
  }
}
