

import 'package:redux/redux.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/actions_base.dart';

final Reducer<RoomiezState> baseReducer = combineReducers([
  TypedReducer<RoomiezState, StartLoadingAction>(beginLoadingReducer),
  TypedReducer<RoomiezState, EndLoadingAction>(endLoadingReducer)
]);

RoomiezState beginLoadingReducer(RoomiezState state, StartLoadingAction action)
  => state.clone(
    isLoading: true
  );
RoomiezState endLoadingReducer(RoomiezState state, EndLoadingAction action)
  => state.clone(
    isLoading: false
  );