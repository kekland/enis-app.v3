import 'package:enis/api/global.dart';
import 'package:enis/pages/intro_page.dart';
import 'package:enis/pages/main_page.dart';
import 'package:enis/pages/settings_page.dart';
import 'package:enis/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
    ),
  );
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  runApp(EnisApp());
}

class EnisApp extends StatefulWidget {
  @override
  EnisAppState createState() => EnisAppState();
}

class EnisAppState extends State<EnisApp> {
  ThemeMode _theme;

  initState() {
    super.initState();
    Global.appState = this;
    updateTheme(false);
  }

  updateTheme([bool callSetState = false]) {
    _theme = Global.themeMode;
    if (callSetState) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eNIS',
      themeMode: _theme,
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
