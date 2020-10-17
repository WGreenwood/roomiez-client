

import 'package:redux/redux.dart';
import 'package:roomiez/models/bills/bill.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/bill_actions.dart';

final Reducer<RoomiezState> billReducer = combineReducers([
  TypedReducer<RoomiezState, GetBillsSuccessAction>(getBillsSuccessReducer),
  TypedReducer<RoomiezState, ClearBillsAction>(clearBillsReducer),
  TypedReducer<RoomiezState, InsertBillSuccessAction>(insertBillSuccessReducer)
]);

RoomiezState getBillsSuccessReducer(RoomiezState state, GetBillsSuccessAction action)
  => state.clone(
    bills: Map.from(state.bills)..addEntries(action.bills.entries)
  );

RoomiezState clearBillsReducer(RoomiezState state, ClearBillsAction action)
  => state.clone(
    bills: Map.unmodifiable({}),
  );

RoomiezState insertBillSuccessReducer(RoomiezState state, InsertBillSuccessAction action)
  => state.clone(
    bills: Map.unmodifiable(Map<int, Bill>.from(state.bills)..addAll({action.bill.id: action.bill})),
  );