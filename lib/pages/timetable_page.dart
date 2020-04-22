import 'package:enis/components/subject_widget.dart';
import 'package:enis/components/surface.dart';
import 'package:enis/components/timetable_widget.dart';
import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class TimetablePage extends StatefulWidget {
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: TimetableWidget(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Surface(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TabBar(
                      controller: controller,
                      isScrollable: true,
                      tabs: [
                        Tab(text: 'Понедельник'),
                        Tab(text: 'Вторник'),
                        Tab(text: 'Среда'),
                        Tab(text: 'Четверг'),
                        Tab(text: 'Пятница'),
                        Tab(text: 'Суббота'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
