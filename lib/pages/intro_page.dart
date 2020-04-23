import 'package:enis/api/global.dart';
import 'package:enis/api/hl_api.dart';
import 'package:enis/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroPageLoader(),
    );
  }
}

class IntroPageLoader extends StatefulWidget {
  @override
  _IntroPageLoaderState createState() => _IntroPageLoaderState();
}

class _IntroPageLoaderState extends State<IntroPageLoader> {
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SvgPicture.asset('assets/nis_logo_dark.svg'),
          SizedBox(height: 64.0),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
