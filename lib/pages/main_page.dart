import 'package:enis/pages/grades_page.dart';
import 'package:enis/pages/timetable_page.dart';
import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('eNIS'),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: TimetablePage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.theme.primaryColor,
        selectedItemColor: context.theme.accentColor,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Оценки'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Расписание'),
          ),
        ],
      ),
    );
  }
}
