import 'package:enis/pages/grades_page.dart';
import 'package:enis/pages/timetable_page.dart';
import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;

  @override
  void initState() {
    currentPage = 0;
    super.initState();
  }

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
      body: Stack(
        children: [
          Offstage(
            offstage: currentPage != 0,
            child: GradesPage(),
          ),
          Offstage(
            offstage: currentPage != 1,
            child: TimetablePage(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.theme.primaryColor,
        selectedItemColor: context.theme.accentColor,
        elevation: 0.0,
        onTap: (i) => setState(() => currentPage = i),
        currentIndex: currentPage,
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
