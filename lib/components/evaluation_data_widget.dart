import 'package:enis/api/data/diary_data.dart';
import 'package:enis/components/percent_widget.dart';
import 'package:enis/components/surface.dart';
import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class EvaluationDataWidget extends StatelessWidget {
  final EvaluationExpandedData data;

  const EvaluationDataWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Surface(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.evaluationData.shortName,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: context.textTheme.caption.color,
            ),
          ),
          ...data.rubricData.map(
            (v) => Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: RubricDataWidget(data: v),
            ),
          ),
        ],
      ),
    );
  }
}

class RubricDataWidget extends StatelessWidget {
  final EvaluationRubricData data;

  const RubricDataWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                data.description,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: context.textTheme.caption.color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0),
        AssessmentWidget(
          score: data.score,
          maxScore: data.maxScore,
        ),
      ],
    );
  }
}
