import 'package:enis/api/data/diary_data.dart';
import 'package:enis/api/data/student_data.dart';
import 'package:enis/api/global.dart';
import 'package:enis/api/hl_api.dart';
import 'package:enis/components/subject_widget.dart';
import 'package:enis/components/surface.dart';
import 'package:enis/components/text_field.dart';
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
  int selectedQuarter;
  LoadedStudentData selectedStudent;
  Map<int, QuarterData> data;

  @override
  void initState() {
    isPickerVisible = false;
    selectedQuarter = Global.prefs.getInt('selectedQuarter') ?? 0;
    controller = new TabController(initialIndex: selectedQuarter, length: 4, vsync: this);

    reloadQuarterData();
    

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadStudentData();
    });

    controller.addListener(() {
      setPage(controller.index);
    });

    super.initState();
  }

  loadStudentData() async {
    if (Global.students == null) {
      runAsyncTaskWithoutIndicator(
        context: context,
        task: () async {
          Global.students = await HighLevelApi.getAllStudents();
          setStudent(Global.students[0].data.id);
        },
      );
    }
  }

  reloadQuarterData([bool reloadState = false]) async {
    data = {
      0: null,
      1: null,
      2: null,
      3: null,
    };

    setPage(selectedQuarter);
    if (reloadState) setState(() {});
  }

  setStudent(String id) {
    setState(() {
      selectedStudent = Global.students.firstWhere((s) => s.data.id == id);
    });

    reloadQuarterData(true);
  }

  setPage(int index) async {
    Global.prefs.setInt('selectedQuarter', index);
    setState(() => selectedQuarter = index);

    if (data[index] == null && selectedStudent != null) {
      runAsyncTaskWithoutIndicator(
        context: context,
        task: () async {
          data[index] = await HighLevelApi.getQuarterData(
            index: index,
            student: selectedStudent,
          );

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
              Surface(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: BeautifulSelect(
                  backgroundColor: Colors.transparent,
                  selected: selectedStudent?.data?.id,
                  icon: Icons.person,
                  borderRadius: BorderRadius.circular(12.0),
                  hint: 'Выберите ученика',
                  onSelected: setStudent,
                  items: Global.students
                      .map(
                        (student) => DropdownMenuItem(
                          value: student.data.id,
                          child: Text(
                              '${student.classData.name} - ${student.data.name}'),
                        ),
                      )
                      .cast<DropdownMenuItem>()
                      .toList(),
                ),
              ),
              SizedBox(height: 16.0),
              if (data[selectedQuarter] == null)
                CircularProgressIndicator()
              else
                ...data[selectedQuarter]
                    .subjects
                    .map(
                      (data) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: SubjectWidget(data: data),
                      ),
                    )
                    .cast<Widget>()
                    .toList()
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
                  '${selectedQuarter + 1} четверть',
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
