import 'dart:convert';

import 'package:enis/api/data/diary_data.dart';
import 'package:enis/api/data/schedule_data.dart';
import 'package:enis/api/data/student_data.dart';
import 'package:enis/api/data/user_data.dart';
import 'package:requests/requests.dart';

import 'global.dart';

class Api {
  static Future<dynamic> makeRequest(
    String path, {
    dynamic body,
    bool hasAuth = true,
    UserData userData,
    Map<String, String> additionalHeaders,
    bool saveCookies = true,
  }) async {
    final _userData = userData ?? Global.userData;

    final headers = <String, String>{};

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    final response = await Requests.post(
      '${_userData.schoolUrl}$path',
      body: body,
      headers: headers,
      bodyEncoding: RequestBodyEncoding.JSON,
      persistCookies: true,
    );

    response.raiseForStatus();

    final responseBody = response.json();

    if (responseBody['success']) {
      return responseBody;
    } else
      throw Exception(responseBody['message']);
  }

  static Future<void> signIn({UserData userData}) async {
    final body = await makeRequest(
      '/root/Account/LogOn',
      body: {
        "login": userData.username,
        "password": userData.password,
        "captchaInput": ""
      },
      hasAuth: false,
      userData: userData,
      saveCookies: true,
    );

    Global.userData = userData;
    await Global.save();
  }

  static Future<ScheduleData> getSchedule() async {
    final body = await makeRequest(
      '/MySchedule/GetMySchedule',
    );

    return ScheduleData.fromJson(body['data']);
  }

  static Future<PeriodsData> getPeriods() async {
    final body = await makeRequest(
      '/JceDiary/GetCurrentPeriods',
    );

    return PeriodsData.fromJson(body['data']);
  }

  static Future<ParallelsData> getParallels({Period period}) async {
    final body = await makeRequest(
      '/JceDiary/GetParallels',
      body: {
        "periodId": period.id,
      },
    );

    return ParallelsData.fromJson(body['data']);
  }

  static Future<ClassData> getClasses({
    Period period,
    Parallel parallel,
  }) async {
    final body = await makeRequest(
      '/JceDiary/GetKlasses',
      body: {
        "periodId": period.id,
        "parallelId": parallel.id,
      },
    );

    return ClassData.fromJson(body['data']);
  }

  static Future<StudentsData> getStudent({
    Period period,
    StudentClass studentClass,
  }) async {
    final body = await makeRequest(
      '/JceDiary/GetStudents',
      body: {
        "periodId": period.id,
        "klassId": studentClass.id,
      },
    );

    return StudentsData.fromJson(body['data']);
  }

  static Future<String> getJceDiaryUrl({
    Period period,
    LoadedStudentData student,
  }) async {
    final body = await makeRequest(
      '/JceDiary/GetJceDiary',
      body: {
        "periodId": period.id,
        "parallelId": student.parallelData.id,
        "klassId": student.classData.id,
        "studentId": student.data.id,
      },
    );

    return body['data']['Url'];
  }

  static Future<void> loadJceDiaryUrl({String url}) async {
    await Requests.post(url);
  }

  static Future<QuarterData> getSubjectsResults({String url}) async {
    final body =
        await makeRequest('/Jce/Diary/GetSubjects', additionalHeaders: {
      "Referer": url,
    });

    return QuarterData.fromJson(body['data']);
  }

  static Future<EvaluationExpandedData> getEvaluationResults({
    SubjectData subject,
    EvaluationData evaluation,
  }) async {
    final body = await makeRequest('/Jce/Diary/GetResultByEvalution', body: {
      "journalId": subject.journalId,
      "evalId": evaluation.id,
    });

    return EvaluationExpandedData.fromJson(body['data'], evaluation);
  }
}
