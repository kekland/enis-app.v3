import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class PercentWidget extends StatelessWidget {
  final double percentage;

  const PercentWidget({Key key, this.percentage}) : super(key: key);

  String get percentageInteger {
    return percentage.truncate().toString();
  }

  String get percentageDecimal {
    return ((percentage - percentage.floor()) * 100.0).truncate().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          percentageInteger,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '.$percentageDecimal%',
          style: TextStyle(
            color: context.textTheme.caption.color,
          ),
        ),
      ],
    );
  }
}

class GradeWidget extends StatelessWidget {
  final int grade;

  const GradeWidget({Key key, this.grade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: grade == 0
          ? []
          : [
              Text(
                'оценка ',
                style: TextStyle(
                  fontSize: 12.0,
                  color: context.textTheme.caption.color,
                ),
              ),
              Text(
                '$grade',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
    );
  }
}

class AssessmentWidget extends StatelessWidget {
  final int score;
  final int maxScore;

  const AssessmentWidget({Key key, this.score, this.maxScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$score',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '/$maxScore',
          style: TextStyle(
            color: context.textTheme.caption.color,
          ),
        ),
      ],
    );
  }
}
