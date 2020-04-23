import 'package:enis/api/data/schedule_data.dart';
import 'package:enis/api/hl_api.dart';
import 'package:enis/components/subject_widget.dart';
import 'package:enis/components/surface.dart';
import 'package:enis/components/timetable_widget.dart';
import 'package:enis/utils.dart';
import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class TimetablePage extends StatefulWidget {
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  ScheduleData data;
  int dayIndex;

  @override
  void initState() {
    super.initState();

    dayIndex = DateTime.now().weekday - 1;
    controller = new TabController(initialIndex: dayIndex, length: 6, vsync: this);

    controller.addListener(() {
      setState(() => dayIndex = controller.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load();
    });
  }

  void load([bool forceLoad = false]) {
    if (!forceLoad && data != null) return;

    runAsyncTaskWithoutIndicator(
      context: context,
      task: () async {
        data = await HighLevelApi.getSchedule();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        (data == null)
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: TimetableWidget(
                  dayData: data.days[dayIndex],
                ),
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
