import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:enis/api/data/diary_data.dart';
import 'package:enis/api/data/student_data.dart';
import 'package:enis/api/global.dart';
import 'package:enis/api/hl_api.dart';
import 'package:enis/components/quarter_picker_widget.dart';
import 'package:enis/components/student_picker_widget.dart';
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

class _GradesPageState extends State<GradesPage> with TickerProviderStateMixin {
  TabController controller;
  int selectedQuarter;
  LoadedStudentData selectedStudent;
  Map<int, QuarterData> data;

  AnimationController quarterPickerAnimationController;
  Animation<double> quarterPickerAnimation;

  @override
  void initState() {
    selectedQuarter = Global.prefs.getInt('selectedQuarter') ?? 0;
    controller = new TabController(
        initialIndex: selectedQuarter, length: 4, vsync: this);

    quarterPickerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    quarterPickerAnimation = CurvedAnimation(
        parent: quarterPickerAnimationController, curve: Curves.easeInOut);

    quarterPickerAnimationController.addListener(() => setState(() => {}));

    reloadQuarterData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadStudentData();
    });

    controller.addListener(() {
      setPage(controller.index);
    });

    super.initState();
  }

  dispose() {
    quarterPickerAnimationController.dispose();
    super.dispose();
  }

  loadStudentData() async {
    if (Global.students == null) {
      runAsyncTaskWithoutIndicator(
        context: context,
        task: () async {
          Global.students = await HighLevelApi.getAllStudents();
          setStudent(Global.students[0]);
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

  setStudent(LoadedStudentData student) {
    setState(() {
      selectedStudent = student;
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
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 300),
      crossFadeState: Global.students != null
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: Center(
        child: CircularProgressIndicator(),
      ),
      secondChild: Global.students == null
          ? Container()
          : Stack(
              children: <Widget>[
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      StudentPickerWidget(
                        students: Global.students,
                        onSelected: (v) => setStudent(v),
                        selected: selectedStudent,
                      ),
                      SizedBox(height: 16.0),
                      if (data[selectedQuarter] == null) ...[
                        SizedBox(height: 48.0),
                        CircularProgressIndicator(),
                      ] else
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Transform.scale(
                      scale: 1.0 - quarterPickerAnimation.value,
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
                          quarterPickerAnimationController.forward();
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularRevealAnimation(
                      animation: quarterPickerAnimationController,
                      centerAlignment: Alignment.centerRight,
                      child: QuarterPickerWidget(
                        controller: controller,
                        onClose: () {
                          quarterPickerAnimationController.reverse();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
