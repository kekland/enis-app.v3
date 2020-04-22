import 'package:enis/api/global.dart';
import 'package:enis/api/hl_api.dart';
import 'package:enis/utils.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkAuth());
  }

  checkAuth() async {
    await Global.load();

    if (Global.userData == null) {
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, '/auth');
    } else {
      try {
        await HighLevelApi.signIn(userData: Global.userData);
        Navigator.pushReplacementNamed(context, '/main');
      } catch (e) {
        showScaffoldError(context, e);
        Navigator.pushReplacementNamed(context, '/auth');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Loading...'));
  }
}
