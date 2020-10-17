
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:roomiez/data/rest_ds.dart';
import 'package:roomiez/http/exceptions/server_response_exception.dart';

import 'package:roomiez/models/auth/access_token.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/models/auth/user.dart';
import 'package:roomiez/redux/actions/actions_base.dart';

typedef RequestErrorHandler = void Function(int errorCode, dynamic errorData);

ThunkAction<RoomiezState> loginRequest(
  {
    @required String email,
    @required String password,
    RequestErrorHandler onError
  }) => (Store<RoomiezState> store) async {
    store.dispatch(StartLoadingAction());
    store.dispatch(AuthResetAction());
    try {
      final dataSource = RestDataSource();
      final response = await dataSource.login(store.state.hostUri, email, password);

      store.dispatch(LoginSuccessAction(
        token: response.tokenInstance,
        user: response.user,
      ));
      await Future.delayed(Duration(milliseconds: 500));
      store.dispatch(NavigationAction(
        path: '/',
        replace: true
      ));
    } on ServerResponseException catch (ex) {
      onError?.call(ex.errorCode, ex.errorData);
      store.dispatch(EndLoadingAction());
    }
  };

ThunkAction<RoomiezState> signUpRequest(
  {
    @required String displayName,
    @required String email,
    @required String password,
    RequestErrorHandler onError
  }) => (Store<RoomiezState> store) async {
    store.dispatch(StartLoadingAction());
    store.dispatch(AuthResetAction());
    try {
      final dataSource = RestDataSource();
      final newUser = await dataSource.signUp(store.state.hostUri, displayName, email, password);
      store.dispatch(SignUpSuccessAction(newUser));
    } on ServerResponseException catch (ex) {
      onError?.call(ex.errorCode, ex.errorData);
    }
    store.dispatch(EndLoadingAction());
  };

ThunkAction<RoomiezState> logout()
  => (Store<RoomiezState> store) async {
    store.dispatch(StartLoadingAction());
    store.dispatch(NavigationAction(
      path: '/login',
      replace: true,
    )); // Goto login page
    await Future.delayed(Duration(milliseconds: 1000));
    store.dispatch(LogoutAction()); // Reset auth state & save
    store.dispatch(EndLoadingAction());
  };

class UpdateHostAddressAction {
  final String hostAddress;
  UpdateHostAddressAction({this.hostAddress});
}
class AuthResetAction {}
class LogoutAction {}

class LoginSuccessAction {
  final User user;
  final AccessToken token;

  LoginSuccessAction({this.user, this.token});
}
class SignUpSuccessAction extends RemovePageAction {
  final User newUser;
  SignUpSuccessAction(this.newUser);
}