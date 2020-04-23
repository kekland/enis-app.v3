class ScheduleData {
  final List<ScheduleDataForDay> days;

  ScheduleData({this.days});

  factory ScheduleData.fromJson(List<dynamic> json) {
    List<ScheduleDataForDay> days = <ScheduleDataForDay>[];

    for (int i = 0; i < 6; i++)
      days.add(ScheduleDataForDay(subjects: <ScheduleSubject>[]));

    json.forEach((lessonGroup) {
      for (int i = 0; i <= 5; i++) {
        String key = '${i + 1}_Records';
        if (lessonGroup.containsKey(key)) {
          days[i].subjects.add(ScheduleSubject.fromJson(lessonGroup[key][0]));
        }
      }
    });

    return ScheduleData(days: days);
  }
}

class ScheduleDataForDay {
  final List<ScheduleSubject> subjects;

  ScheduleDataForDay({this.subjects});
}

class ScheduleSubject {
  final String subjectName;
  final String cabinetName;
  final String teacherName;
  final String groupName;

  ScheduleSubject({
    this.subjectName,
    this.cabinetName,
    this.teacherName,
    this.groupName,
  });

  factory ScheduleSubject.fromJson(Map<String, dynamic> json) {
    return ScheduleSubject(
      cabinetName: json['CabinetName'],
      groupName: json['GroupName'],
      subjectName: json['SubjectName'],
      teacherName: json['TeacherName'],
    );
  }
}
