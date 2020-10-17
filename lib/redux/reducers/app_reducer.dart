
import 'package:redux/redux.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/reducers/auth_reducer.dart';
import 'package:roomiez/redux/reducers/base_reducer.dart';
import 'package:roomiez/redux/reducers/bill_reducer.dart';
import 'package:roomiez/redux/reducers/settings_reducer.dart';

Reducer<RoomiezState> appReducer = combineReducers([
  authReducer,
  baseReducer,
  billReducer,
  settingsReducer,
]);
