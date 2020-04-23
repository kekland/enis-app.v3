import 'package:enis/pages/intro_page.dart';
import 'package:enis/pages/main_page.dart';
import 'package:enis/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eNIS',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.green,
        brightness: Brightness.light,
        canvasColor: Color(0xFFF5F5F5),
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.green,
        brightness: Brightness.dark,
        cardColor: Colors.black,
        bottomAppBarColor: Colors.black,
        canvasColor: Color(0xFF0C0C0C),
      ),
      home: IntroPage(),
      routes: {
        '/intro': (context) => IntroPage(),
        '/auth': (context) => SignInPage(),
        '/main': (context) => MainPage(),
      },
    );
  }
}
