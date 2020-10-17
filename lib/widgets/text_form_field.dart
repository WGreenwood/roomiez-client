
import 'package:flutter/material.dart';
import 'package:roomiez/data/validation.dart' as validators;

class TextFormFieldWrap extends StatelessWidget {
  final String labelText;
  final String heroTag;
  final String initialValue;
  final TextInputAction textInputAction;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool enabled;
  final bool obscureText;
  final TextInputType inputType;
  final void Function(String) onSaved;
  final String Function(String) validator;

  TextFormFieldWrap(
    {
      @required this.labelText,
      this.heroTag,
      this.initialValue,
      this.textInputAction = TextInputAction.next,
      this.prefixIcon,
      this.controller,
      this.enabled = true,
      this.obscureText = false,
      this.inputType = TextInputType.text,
      this.onSaved,
      this.validator
    }
  );


  @override
  Widget build(BuildContext context)
  {
    Widget child = Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        autofocus: false,
        controller: controller,
        obscureText: obscureText,
        initialValue: initialValue,
        textInputAction: textInputAction,
        enabled: enabled,
        onSaved: onSaved,
        validator: validator,
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          hintText: labelText,
          labelText: labelText,
          hasFloatingPlaceholder: true,
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
    if (this.heroTag != null)
      child = Hero(
        tag: this.heroTag,
        child: Material(child: child),
      );
    return child;
  }
}

class HostAddressTextFormField extends TextFormFieldWrap {
  HostAddressTextFormField({
    String initialValue,
    bool enabled,
    void Function(String) onSaved,
  }) : super(
      labelText: 'Host Address',
      heroTag: 'host-address-input',
      initialValue: initialValue,
      prefixIcon: Icons.cloud_queue,
      enabled: enabled,
      obscureText: false,
      onSaved: onSaved,
      validator: validators.hostAddress,
    );
}

class DisplayNameTextFormField extends TextFormFieldWrap {
  DisplayNameTextFormField({
    bool enabled,
    String initialValue,
    void Function(String) onSaved,
  }) : super(
      labelText: 'Display Name',
      heroTag: 'display-name-input',
      initialValue: initialValue,
      prefixIcon: Icons.account_circle,
      enabled: enabled,
      obscureText: false,
      onSaved: onSaved,
      validator: validators.displayName,
    );
}

class EmailTextFormField extends TextFormFieldWrap {
  EmailTextFormField({
    bool enabled,
    String initialValue,
    void Function(String) onSaved,
  }) : super(
      labelText: 'Email',
      heroTag: 'email-input',
      initialValue: initialValue,
      prefixIcon: Icons.alternate_email,
      enabled: enabled,
      obscureText: false,
      onSaved: onSaved,
      validator: validators.displayName,
    );
}

class PasswordTextFormField extends TextFormFieldWrap {
  PasswordTextFormField({
    bool enabled,
    String initialValue,
    void Function(String) onSaved,
  }) : super(
      labelText: 'Password',
      heroTag: 'password-input',
      initialValue: initialValue,
      textInputAction: TextInputAction.go,
      prefixIcon: Icons.lock_outline,
      enabled: enabled,
      obscureText: true,
      onSaved: onSaved,
      validator: validators.password,
    );
}

class CostTextFormField extends TextFormFieldWrap {
  CostTextFormField({
    bool enabled,
    void Function(String) onSaved,
  }) : super(
    labelText: 'Cost',
    heroTag: 'cost-input',
    prefixIcon: Icons.attach_money,
    enabled: enabled,
    onSaved: onSaved,
    validator: validators.cost,
    inputType: TextInputType.numberWithOptions(
        decimal: true, signed: false),
  );
}
