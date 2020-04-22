import 'package:enis/api/global.dart';
import 'package:enis/api/hl_api.dart';
import 'package:enis/components/subject_widget.dart';
import 'package:enis/components/surface.dart';
import 'package:enis/utils.dart';
import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class GradesPage extends StatefulWidget {
  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  bool isPickerVisible;

  @override
  void initState() {
    controller = new TabController(length: 4, vsync: this);
    isPickerVisible = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadStudentData();
    });

    super.initState();
  }

  loadStudentData() async {
    if (Global.students == null) {
      runAsyncTask(
        context: context,
        task: () async {
          Global.students = await HighLevelApi.getAllStudents();
          setState(() {});
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Global.students == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SubjectWidget(),
            ],
          ),
        ),
        if (!isPickerVisible)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                icon: Icon(Icons.timelapse),
                elevation: 0.0,
                label: Text(
                  '3 четверть',
                  style: context.textTheme.body1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  setState(() => isPickerVisible = true);
                },
              ),
            ),
          ),
        if (isPickerVisible)
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
                        tabs: [
                          Tab(text: '1'),
                          Tab(text: '2'),
                          Tab(text: '3'),
                          Tab(text: '4'),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: () {
                        setState(() => isPickerVisible = false);
                      },
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
