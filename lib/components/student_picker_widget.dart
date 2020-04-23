import 'package:enis/api/data/student_data.dart';
import 'package:enis/components/surface.dart';
import 'package:enis/components/text_field.dart';
import 'package:flutter/material.dart';

class StudentPickerWidget extends StatelessWidget {
  final List<LoadedStudentData> students;
  final LoadedStudentData selected;
  final Function(LoadedStudentData) onSelected;

  const StudentPickerWidget({
    Key key,
    this.students,
    this.selected,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Surface(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: BeautifulSelect(
        backgroundColor: Colors.transparent,
        selected: selected?.data?.id,
        icon: Icons.person,
        borderRadius: BorderRadius.circular(12.0),
        hint: 'Выберите ученика',
        onSelected: (id) => onSelected(
          students.firstWhere((s) => s.data.id == id),
        ),
        items: students
            .map(
              (student) => DropdownMenuItem(
                value: student.data.id,
                child: Text('${student.classData.name} - ${student.data.name}'),
              ),
            )
            .cast<DropdownMenuItem>()
            .toList(),
      ),
    );
  }
}
