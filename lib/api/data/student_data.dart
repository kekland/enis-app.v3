class Period {
  final String id;

  Period({this.id});

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(id: json['Id']);
  }
}

class PeriodsData {
  final List<Period> periods;

  PeriodsData({this.periods});

  factory PeriodsData.fromJson(List<dynamic> json) {
    return PeriodsData(
      periods:
          json.map((period) => Period.fromJson(period)).cast<Period>().toList(),
    );
  }
}

class Parallel {
  final String id;
  final String name;

  Parallel({this.id, this.name});

  factory Parallel.fromJson(Map<String, dynamic> json) {
    return Parallel(id: json['Id'], name: json['Name']);
  }
}

class ParallelsData {
  final List<Parallel> parallels;

  ParallelsData({this.parallels});

  factory ParallelsData.fromJson(List<dynamic> json) {
    return ParallelsData(
      parallels: json
          .map((parallel) => Parallel.fromJson(parallel))
          .cast<Parallel>()
          .toList(),
    );
  }
}

class StudentClass {
  final String id;
  final String name;
  final String schoolYearName;
  final String parallelName;
  final String letterName;
  final String language;

  StudentClass({
    this.id,
    this.name,
    this.schoolYearName,
    this.parallelName,
    this.letterName,
    this.language,
  });

  factory StudentClass.fromJson(Map<String, dynamic> json) {
    return StudentClass(
      id: json['Id'],
      language: json['LanguageName'],
      letterName: json['LetterName'],
      name: json['Name'],
      parallelName: json['ParallelName'],
      schoolYearName: json['SchoolYearName'],
    );
  }
}

class ClassData {
  final List<StudentClass> classes;

  ClassData({this.classes});

  factory ClassData.fromJson(List<dynamic> json) {
    return ClassData(
      classes:
          json.map((_class) => StudentClass.fromJson(_class)).cast<StudentClass>().toList(),
    );
  }
}

class Student {
  final String id;
  final String name;

  Student({this.id, this.name});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['Id'],
      name: json['Name'],
    );
  }
}

class StudentsData {
  final List<Student> students;

  StudentsData({this.students});

  factory StudentsData.fromJson(List<dynamic> json) {
    return StudentsData(
      students: json
          .map((student) => Student.fromJson(student))
          .cast<Student>()
          .toList(),
    );
  }
}

class LoadedStudentData {
  final Student data;
  final StudentClass classData;
  final Parallel parallelData;

  LoadedStudentData({
    this.data,
    this.classData,
    this.parallelData,
  });
}
