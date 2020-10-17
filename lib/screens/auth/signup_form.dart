import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/http/error_codes.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/auth_actions.dart';
import 'package:roomiez/screens/auth/view_model.dart';
import 'package:roomiez/widgets/widgets.dart';

class SignUpForm extends StatefulWidget {
  static const String routeName = '/signup';
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String _hostAddress, _displayName, _email, _password;

  void _onFormSubmit() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    final dispatch = globals.roomiezStore.dispatch;
    dispatch(UpdateHostAddressAction(
      hostAddress: _hostAddress
    ));
    dispatch(signUpRequest(
      displayName: _displayName,
      email: _email,
      password: _password,
      onError: (code, data) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(ErrorCodes.English[code])
        ));
      }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: StoreConnector<RoomiezState, AuthViewModel>(
          converter: (store) => AuthViewModel(
            isLoading: store.state.isLoading,
            lastHostAddress: store.state.hostAddress,
          ),
          builder: (context, view)
            => Column(
              children: <Widget>[
                HostAddressTextFormField(
                  initialValue: view.lastHostAddress,
                  enabled: view.isNotLoading,
                  onSaved: (hostAddress) => _hostAddress = hostAddress,
                ),
                DisplayNameTextFormField(
                  enabled: view.isNotLoading,
                  onSaved: (displayName) => _displayName = displayName,
                ),
                EmailTextFormField(
                  enabled: view.isNotLoading,
                  onSaved: (email) => _email = email,
                ),
                PasswordTextFormField(
                  enabled: view.isNotLoading,
                  onSaved: (password) => _password = password,
                ),
                TwoColumnRow(
                  leftChild: RaisedButtonWrap(
                    text: 'Cancel',
                    heroTag: 'right',
                    icon: Icons.arrow_back,
                    enabled: view.isNotLoading,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  rightChild: SignUpButton(
                    heroTag: 'left',
                    enabled: view.isNotLoading,
                    onPressed: _onFormSubmit,
                  ),
                ),
                SizedBox(height: 12),
                ProgressRing(enabled: view.isLoading),
              ],
            ),
        ),
      ),
    );
  }
}