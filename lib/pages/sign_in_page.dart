import 'package:enis/api/data/user_data.dart';
import 'package:enis/api/hl_api.dart';
import 'package:enis/api/schools.dart';
import 'package:enis/components/app_logo_text.dart';
import 'package:enis/components/text_field.dart';
import 'package:enis/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SignInForm(),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController usernameController;
  TextEditingController passwordController;
  String selectedSchoolKey;

  initState() {
    usernameController = TextEditingController(text: '020421500643');
    passwordController = TextEditingController(text: 'Qwedcxza21');
    selectedSchoolKey = null;

    usernameController.addListener(() => setState(() => {}));
    passwordController.addListener(() => setState(() => {}));

    super.initState();
  }

  dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  signIn() {
    runAsyncTask(
      context: context,
      task: () async {
        await HighLevelApi.signIn(
          userData: UserData(
            username: usernameController.text,
            password: passwordController.text,
            schoolUrl: schools[selectedSchoolKey],
          ),
        );

        Navigator.of(context).pushReplacementNamed('/main');
      },
    );
  }

  bool get isValid {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        selectedSchoolKey != null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppLogoTextWidget(),
          SizedBox(height: 16.0),
          BeautifulTextField(
            controller: usernameController,
            icon: Icons.account_circle,
            hint: 'ИИН',
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12.0),
            ),
          ),
          Divider(
            height: 1.0,
          ),
          BeautifulTextField(
            controller: passwordController,
            icon: Icons.lock,
            hint: 'Пароль',
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12.0),
            ),
          ),
          SizedBox(height: 16.0),
          BeautifulSelect(
            borderRadius: BorderRadius.circular(12.0),
            hint: 'Школа',
            icon: Icons.school,
            onSelected: (v) => setState(() => selectedSchoolKey = v),
            selected: selectedSchoolKey,
            items: schools.keys
                .map(
                  (key) => DropdownMenuItem(
                    child: Text(key),
                    value: key,
                  ),
                )
                .cast<DropdownMenuItem>()
                .toList(),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              icon: Icon(Icons.chevron_right),
              label: Text('Войти'),
              onPressed: isValid ? signIn : null,
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
