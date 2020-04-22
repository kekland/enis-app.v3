class PeriodsData {
  final List<String> identifiers;

  PeriodsData({this.identifiers});

  factory PeriodsData.fromJson(List<Map<String, dynamic>> json) {
    return PeriodsData(
      identifiers: json.map((period) => period['Id']).cast<String>().toList(),
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

  factory ParallelsData.fromJson(List<Map<String, dynamic>> json) {
    return ParallelsData(
      parallels: json
          .map((parallel) => Parallel.fromJson(parallel))
          .cast<Parallel>()
          .toList(),
    );
  }
}

class _Class {
  final String id;
  final String name;
  final String schoolYearName;
  final String parallelName;
  final String letterName;
  final String language;

  _Class({
    this.id,
    this.name,
    this.schoolYearName,
    this.parallelName,
    this.letterName,
    this.language,
  });

  factory _Class.fromJson(Map<String, dynamic> json) {
    return _Class(
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
  final List<_Class> classes;

  ClassData({this.classes});

  factory ClassData.fromJson(List<Map<String, dynamic>> json) {
    return ClassData(
      classes:
          json.map((_class) => _Class.fromJson(_class)).cast<_Class>().toList(),
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

  factory StudentsData.fromJson(List<Map<String, dynamic>> json) {
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
  final _Class classData;
  final Parallel parallelData;

  LoadedStudentData({
    this.data,
    this.classData,
    this.parallelData,
  });
}
