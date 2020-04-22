class EvaluationData {
  final String name;
  final String shortName;
  final String evaluationId;

  EvaluationData({this.name, this.shortName, this.evaluationId});

  factory EvaluationData.fromJson(Map<String, dynamic> json) {
    return EvaluationData(
      name: json['Name'],
      shortName: json['ShortName'],
      evaluationId: json['Id'],
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
