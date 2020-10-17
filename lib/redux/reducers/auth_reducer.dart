import 'package:redux/redux.dart';
import 'package:roomiez/models/auth/access_token.dart';
import 'package:roomiez/models/auth/auth_state.dart';

import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/auth_actions.dart';

final Reducer<RoomiezState> authReducer = combineReducers([
  TypedReducer<RoomiezState, UpdateHostAddressAction>(updateHostAddressReducer),
  TypedReducer<RoomiezState, AuthResetAction>(authResetReducer),
  TypedReducer<RoomiezState, LogoutAction>(logoutReducer),
  TypedReducer<RoomiezState, LoginSuccessAction>(loginSuccessReducer),
  TypedReducer<RoomiezState, SignUpSuccessAction>(signUpSuccessReducer),
]);

RoomiezState updateHostAddressReducer(RoomiezState state, UpdateHostAddressAction action)
  => state.clone(
    hostAddress: action.hostAddress,
  );

RoomiezState authResetReducer(RoomiezState state, AuthResetAction action)
  => state.clone(
    auth: AuthState.initial(),
  );
RoomiezState logoutReducer(RoomiezState state, LogoutAction action) => authResetReducer(state, null);

RoomiezState loginSuccessReducer(RoomiezState state, LoginSuccessAction action)
  => state.clone(
    lastEmail: action.user.email,
    auth: state.auth.clone(
      accessToken: action.token,
      currentUser: action.user,
    ),
  );

RoomiezState signUpSuccessReducer(RoomiezState state, SignUpSuccessAction action)
  => state.clone(
    lastEmail: action.newUser.email,
    auth: AuthState(
      accessToken: AccessToken.nullInstance,
      currentUser: action.newUser,
    )
  );
