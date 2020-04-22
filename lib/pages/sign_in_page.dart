import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(),
              TextField(),
              RaisedButton(
                child: Text('Войти'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
