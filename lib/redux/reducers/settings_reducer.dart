
import 'package:redux/redux.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/settings_actions.dart';


final Reducer<RoomiezState> settingsReducer = combineReducers([
  TypedReducer<RoomiezState, UpdateStartupPageAction>(updateStartupPageReducer),
  TypedReducer<RoomiezState, UpdateThemeAction>(updateThemeReducer),
]);

RoomiezState updateStartupPageReducer(RoomiezState state, UpdateStartupPageAction action)
  => state.clone(
    startPage: action.startupPageIndex
  );

RoomiezState updateThemeReducer(RoomiezState state, UpdateThemeAction action)
  => state.clone(
    useDarkTheme: action.useDarkTheme
  );