

import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:roomiez/data/rest_ds.dart';
import 'package:roomiez/http/exceptions/server_response_exception.dart';
import 'package:roomiez/http/responses/page_response.dart';
import 'package:roomiez/models/bills/bill.dart';
import 'package:roomiez/models/bills/bill_type.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/actions_base.dart';

ThunkAction<RoomiezState> getBillsRequest({int page = 0, bool clearStoreBefore = false, void Function(PageResponse) responseOut, void Function(int, dynamic) onError})
  => (Store<RoomiezState> store) async {
    if (clearStoreBefore)
      store.dispatch(ClearBillsAction());
    store.dispatch(StartLoadingAction());
    await Future.delayed(Duration(milliseconds: 500));
    try {
      final dataSource = RestDataSource();
      final response = await dataSource.getBills(store.state.hostUri, store.state.auth.accessToken, page: page);
      responseOut?.call(response);
      if (response.items.isNotEmpty)
        store.dispatch(GetBillsSuccessAction(response.items));
    } on ServerResponseException catch (ex) {
      onError?.call(ex.errorCode, ex.errorData);
    } finally {
      store.dispatch(EndLoadingAction());
    }
  };

ThunkAction<RoomiezState> addBillRequest({String name, DateTime currentCycleStart, BillType billType, Decimal cost, void Function(int, dynamic) onError})
  => (Store<RoomiezState> store) async {
    store.dispatch(StartLoadingAction());
    final bill = Bill(
      name: name,
      date: currentCycleStart,
      type: billType,
      cost: cost,
    );
    try {
      await Future.delayed(Duration(seconds: 1));
      final dataSource = RestDataSource();
      final response = await dataSource.addBill(store.state.hostUri, store.state.auth.accessToken, bill);
      store.dispatch(InsertBillSuccessAction(response));
      await Future.delayed(Duration(milliseconds: 500));
      store.dispatch(RemovePageAction());
    } on ServerResponseException catch (ex) {
      onError?.call(ex.errorCode, ex.errorData);
    } finally {
      store.dispatch(EndLoadingAction());
    }
  };

class ClearBillsAction {}
class GetBillsSuccessAction {
  final Map<int, Bill> bills;

  GetBillsSuccessAction(this.bills);
}
class InsertBillSuccessAction {
  final Bill bill;

  InsertBillSuccessAction(this.bill);
}