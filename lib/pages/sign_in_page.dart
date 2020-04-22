import 'package:enis/api/schools.dart';
import 'package:enis/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'eNIS',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    'v3.0',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              BeautifulTextField(
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
                  onPressed: () {},
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
