import 'package:enis/api/api.dart';
import 'package:enis/api/data/diary_data.dart';
import 'package:enis/api/data/schedule_data.dart';
import 'package:enis/api/data/student_data.dart';
import 'package:enis/api/data/user_data.dart';
import 'package:enis/api/global.dart';
import 'package:flutter/material.dart';

class HighLevelApi {
  static Future<void> signIn({UserData userData}) {
    return Api.signIn(userData: userData);
  }

  static Future<PeriodsData> loadPeriods() async {
    return Api.getPeriods();
  }

  static Future<List<LoadedStudentData>> getAllStudents() async {
    final List<LoadedStudentData> responseData = [];

    final periodsData = await loadPeriods();
    final firstPeriod = periodsData.periods[0];

    final parallelsData = await Api.getParallels(period: firstPeriod);
    final parallels = parallelsData.parallels;

    for (final parallel in parallels) {
      final classesData =
          await Api.getClasses(period: firstPeriod, parallel: parallel);
      final classes = classesData.classes;

      for (final studentClass in classes) {
        final studentsData = await Api.getStudent(
            period: firstPeriod, studentClass: studentClass);
        final students = studentsData.students;

        for (final student in students) {
          responseData.add(
            LoadedStudentData(
              data: student,
              classData: studentClass,
              parallelData: parallel,
            ),
          );
        }
      }
    }

    return responseData;
  }

  static Future<ScheduleData> getSchedule() async {
    return Api.getSchedule();
  }

  static Future<QuarterData> getQuarterData(
      {int index, LoadedStudentData student}) async {
    final periodsData = await loadPeriods();
    final period = periodsData.periods[index];

    final url = await Api.getJceDiaryUrl(period: period, student: student);
    await Api.loadJceDiaryUrl(url: url);

    return await Api.getSubjectsResults(url: url);
  }

  static Future<SubjectExpandedData> getExpandedSubjectInfo({
    SubjectData subject,
  }) async {
    final List<EvaluationExpandedData> evaluationExpandedDataList = [];

    for (final evaluation in subject.evaluations) {
      final expandedEvaluationData = await Api.getEvaluationResults(
          evaluation: evaluation, subject: subject);
      evaluationExpandedDataList.add(expandedEvaluationData);
    }

    return SubjectExpandedData(
      subjectData: subject,
      evaluationData: evaluationExpandedDataList,
    );
  }

  static Future logOut({BuildContext context}) async {
    await Global.clear();
    Navigator.of(context).popUntil((v) => v.isFirst);
    Navigator.of(context).pushReplacementNamed('/auth');
  }
}
