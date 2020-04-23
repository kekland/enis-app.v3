import 'package:enis/api/global.dart';
import 'package:enis/api/hl_api.dart';
import 'package:enis/components/app_logo_text.dart';
import 'package:enis/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  setTheme(String v) {
    Global.prefs.setString('theme', v);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 12.0),
        Container(
          width: 32.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                AppLogoTextWidget(),
                SizedBox(height: 12.0),
                BeautifulSelect(
                  hint: 'Тема',
                  icon: Icons.color_lens,
                  items: [
                    DropdownMenuItem(
                        child: Text('Светлая тема'), value: 'light'),
                    DropdownMenuItem(child: Text('Тёмная тема'), value: 'dark'),
                    DropdownMenuItem(
                        child: Text('Системная тема'), value: 'system'),
                  ],
                  selected: Global.getSelectedThemeString(),
                  onSelected: (v) {
                    Global.setTheme(v);
                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(12.0),
                ),
                SizedBox(height: 12.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () => HighLevelApi.logOut(context: context),
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Выйти из профиля'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
