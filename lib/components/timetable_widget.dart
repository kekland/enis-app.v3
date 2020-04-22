import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class TimetableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TimetableLessonJoinedWidget(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TimetableLessonJoinedWidget(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TimetableLessonWidget(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TimetableLessonWidget(),
        ),
      ],
    );
  }
}

class TimetableLessonWidget extends StatelessWidget {
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
              width: 32.0,
              alignment: Alignment.center,
              child: Text(
                '1',
                style: TextStyle(
                  fontSize: 16.0,
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
                      'Физическая культура',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Алих',
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
              color: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }
}

class TimetableLessonJoinedWidget extends StatelessWidget {
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
              width: 32.0,
              alignment: Alignment.center,
              child: Text(
                '1',
                style: TextStyle(
                  fontSize: 16.0,
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
                      'Физическая культура',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Алих',
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
              height: 128.0,
              color: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }
}
