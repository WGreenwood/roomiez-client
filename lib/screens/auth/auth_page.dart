import 'package:flutter/material.dart';
import 'package:roomiez/screens/auth/login_form.dart';
import 'package:roomiez/screens/auth/signup_form.dart';


class AuthPage extends StatelessWidget {
  final Widget Function(BuildContext context) _buildForm;
  AuthPage(this._buildForm);

  factory AuthPage.login()
    => AuthPage((context) => LoginForm());
  factory AuthPage.signup()
    => AuthPage((context) => SignUpForm());

  Widget buildLogo()
    => Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          child: Image(
            height: 120,
            width: 120,
            fit: BoxFit.cover,
            image: AssetImage('assets/logo.png'),
          )),
    );
  Widget buildTitle()
    => Hero(
      tag: 'title',
      child: Material(
        child: Text(
          'Roomiez',
          textAlign: TextAlign.center,
          textScaleFactor: 2.5,
        ),
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            buildLogo(),
            SizedBox(height: 8),
            buildTitle(),
            SizedBox(height: 76),
            _buildForm(context),
          ],
        ),
      ),
    );
  }
}