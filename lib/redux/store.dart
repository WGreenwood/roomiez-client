import 'dart:async';

import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/auth_actions.dart';
import 'package:roomiez/redux/actions/settings_actions.dart';

import 'package:roomiez/redux/middleware/middleware.dart';
import 'package:roomiez/redux/reducers/app_reducer.dart';
import 'package:roomiez/redux/storage_engine.dart';

final List<Type> _saveableActions = [
  LoginSuccessAction,
  SignUpSuccessAction,
  LogoutAction,
  UpdateStartupPageAction,
  UpdateThemeAction,
];

Persistor createPersistor()
  => Persistor<RoomiezState>(
    storage: RoomiezStorageEngine(),
    serializer: JsonSerializer(RoomiezState.fromJson),
    shouldSave: (store, action) => _saveableActions.contains(action.runtimeType),
  );

Future<Store<RoomiezState>> createStore() async {
  final initialState = await globals.roomiezPersistor.load();

  return Store(
    appReducer,
    initialState: initialState ?? RoomiezState.initial(),
    middleware: createMiddleware(),
  );
}