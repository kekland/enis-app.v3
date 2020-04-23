import 'package:enis/api/data/schedule_data.dart';
import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

const List<Color> colors = [
  Colors.green,
  Colors.yellow,
  Colors.red,
  Colors.purple,
  Colors.indigo,
  Colors.blue,
  Colors.cyan,
  Colors.pink,
  Colors.lime,
  Colors.deepPurple,
  Colors.teal,
];

class TimetableWidget extends StatelessWidget {
  final ScheduleDataForDay dayData;

  const TimetableWidget({Key key, this.dayData}) : super(key: key);

  List<Widget> _buildTimetable() {
    List<Widget> widgets = [];
    int runningColorIndex = 0;

    for (int i = 0; i < dayData.subjects.length; i++) {
      bool hasNextSubject = i != dayData.subjects.length - 1;
      final subject = dayData.subjects[i];
      final nextSubject = hasNextSubject ? dayData.subjects[i + 1] : null;

      if (hasNextSubject && subject.subjectName == nextSubject.subjectName) {
        widgets.add(
          TimetableLessonJoinedWidget(
            subject: subject,
            index: i + 1,
            color: colors[runningColorIndex],
          ),
        );
        i += 1;
      } else {
        widgets.add(
          TimetableLessonWidget(
            subject: subject,
            index: i + 1,
            color: colors[runningColorIndex],
          ),
        );
      }
      runningColorIndex += 1;
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildTimetable()
          .map(
            (w) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: w,
            ),
          )
          .toList(),
    );
  }
}

class TimetableLessonWidget extends StatelessWidget {
  final ScheduleSubject subject;
  final Color color;
  final int index;

  const TimetableLessonWidget({Key key, this.subject, this.color, this.index})
      : super(key: key);
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 48.0,
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: context.textTheme.caption.color,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.subjectName,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${subject.teacherName} (${subject.cabinetName})',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: context.textTheme.caption.color,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 4.0,
              height: 64.0,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}

class TimetableLessonJoinedWidget extends StatelessWidget {
  final ScheduleSubject subject;
  final Color color;
  final int index;

  const TimetableLessonJoinedWidget(
      {Key key, this.subject, this.color, this.index})
      : super(key: key);

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 48.0,
              alignment: Alignment.center,
              child: Text(
                '$index-${index + 1}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: context.textTheme.caption.color,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.subjectName,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${subject.teacherName} (${subject.cabinetName})',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: context.textTheme.caption.color,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 4.0,
              height: 96.0,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
