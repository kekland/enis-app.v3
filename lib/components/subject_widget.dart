import 'package:enis/api/data/diary_data.dart';
import 'package:enis/components/percent_widget.dart';
import 'package:enis/components/subject_expanded_widget.dart';
import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class SubjectWidget extends StatelessWidget {
  final SubjectData data;
  final bool clickable;

  const SubjectWidget({
    Key key,
    this.data,
    this.clickable = true,
  }) : super(key: key);

  Color get lineColor {
    if (data.score >= 85.0) {
      return Colors.green;
    } else if (data.score >= 65.0) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0.0, 8.0),
            blurRadius: 12.0,
          )
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: clickable
              ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => SubjectExpandedWidget(
                      data: data,
                    ),
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PercentWidget(percentage: data.score),
                          GradeWidget(grade: data.mark),
                        ],
                      ),
                    ],
                  ),
                ),
                LinearProgressIndicator(
                  backgroundColor: lineColor.withOpacity(0.25),
                  valueColor: AlwaysStoppedAnimation<Color>(lineColor),
                  value: data.score / 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
