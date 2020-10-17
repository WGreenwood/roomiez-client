
import 'package:flutter/material.dart';

class RaisedButtonWrap extends StatelessWidget {
  final String text;
  final String heroTag;
  final IconData icon;
  final bool enabled;
  final void Function() onPressed;

  RaisedButtonWrap(
    {
      this.text,
      this.heroTag,
      this.icon,
      this.enabled = true,
      this.onPressed
    }
  );

  @override
  Widget build(BuildContext context)
  {
    Widget button = Material(
      borderRadius: BorderRadius.circular(3),
      elevation: 5,
      type: MaterialType.button,
      color: Colors.transparent,
      child: RaisedButton.icon(
        label: Text(text),
        icon: Icon(icon),
        onPressed: enabled ? onPressed : null,
      ),
    );
    if (this.heroTag != null)
      button = Hero(
        tag: this.heroTag,
        child: button
      );
    return button;
  }
}

class SignUpButton extends RaisedButtonWrap {
  SignUpButton({
    String heroTag,
    bool enabled = true,
    void Function() onPressed,
  }) : super(
    text: 'Sign Up',
    heroTag: heroTag,
    icon: Icons.person_add,
    enabled: enabled,
    onPressed: onPressed,
  );
}
class LoginButton extends RaisedButtonWrap {
  LoginButton({
    String heroTag,
    bool enabled = true,
    void Function() onPressed,
  }) : super(
    text: 'Login',
    heroTag: heroTag,
    icon: Icons.check,
    enabled: enabled,
    onPressed: onPressed,
  );
}