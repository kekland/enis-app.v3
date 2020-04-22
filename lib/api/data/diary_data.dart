class EvaluationData {
  final String name;
  final String shortName;
  final String id;

  EvaluationData({this.name, this.shortName, this.id});

  factory EvaluationData.fromJson(Map<String, dynamic> json) {
    return EvaluationData(
      name: json['Name'],
      shortName: json['ShortName'],
      id: json['Id'],
    );
  }
}

class SubjectData {
  final String name;
  final String journalId;

  final double score;
  final int mark;

  final List<EvaluationData> evaluations;

  SubjectData({
    this.name,
    this.journalId,
    this.score,
    this.mark,
    this.evaluations,
  });

  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(
      name: json['Name'],
      journalId: json['JournalId'],
      mark: (json['Mark'] as num).toInt(),
      score: (json['Score'] as num).toDouble(),
      evaluations: (json['Evaluations'] as List)
          .map(
            (evaluation) => EvaluationData.fromJson(evaluation),
          )
          .cast<EvaluationData>()
          .toList(),
    );
  }
}

class QuarterData {
  final List<SubjectData> subjects;

  QuarterData({this.subjects});

  factory QuarterData.fromJson(List<dynamic> json) {
    return QuarterData(
      subjects: json.map(
        (subject) => SubjectData.fromJson(subject),
      ),
    );
  }
}

class EvaluationRubricData {
  final String name;
  final String description;
  final int score;
  final int maxScore;

  EvaluationRubricData({
    this.name,
    this.description,
    this.score,
    this.maxScore,
  });

  factory EvaluationRubricData.fromJson(Map<String, dynamic> json) {
    return EvaluationRubricData(
      name: json['Name'],
      description: json['Description'],
      score: (json['Score'] as num).toInt(),
      maxScore: (json['MaxScore'] as num).toInt(),
    );
  }
}

class EvaluationExpandedData {
  final EvaluationData evaluationData;
  final List<EvaluationRubricData> rubricData;

  EvaluationExpandedData({this.evaluationData, this.rubricData});

  factory EvaluationExpandedData.fromJson(
    List<dynamic> json, [
    EvaluationData evaluationData,
  ]) {
    return EvaluationExpandedData(
      evaluationData: evaluationData,
      rubricData: json
          .map((rubric) => EvaluationRubricData.fromJson(rubric))
          .cast<EvaluationRubricData>()
          .toList(),
    );
  }
}

class SubjectExpandedData {
  final SubjectData subjectData;
  final List<EvaluationExpandedData> evaluationData;

  SubjectExpandedData({this.subjectData, this.evaluationData});
}
