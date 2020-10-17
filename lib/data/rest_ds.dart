import 'dart:async';
import 'dart:io';
import 'package:roomiez/http/responses/payment_response.dart';
import 'package:decimal/decimal.dart';
import 'package:roomiez/http/exceptions/server_response_exception.dart';

import 'package:roomiez/http/responses.dart';
import 'package:roomiez/models/auth/access_token.dart';
import 'package:roomiez/models/auth/user.dart';
import 'package:roomiez/models/bills/bill.dart';
import 'package:roomiez/models/bills/bill_payment.dart';
import 'package:roomiez/models/bills/billing_cycle.dart';
import 'package:roomiez/utils/network_util.dart';

class RestDataSource {
  static final RestDataSource _instance = RestDataSource._internal();
  RestDataSource._internal();
  factory RestDataSource() => _instance;

  static final Map<String, String> _defaultHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  Map<String, String> _makeAuthHeaders(AccessToken token)
    => {
      HttpHeaders.authorizationHeader: 'Bearer ${token.value}'
    }..addEntries(_defaultHeaders.entries);

  void _basicResponseCheck(ServerResponse response) {
    if (response == null)
      throw ServerResponseException(
        errorCode: -1,
        errorData: null,
      );
    if (!response.success)
      throw ServerResponseException(
        errorCode: response.code,
        errorData: response.result,
      );
  }

  Future<TokenResponse> login(Uri hostUri, String email, String password) async {
    final loginUri = hostUri.resolve('/auth/login');
    final body = {
      'email': email,
      'password': password,
    };

    final network = NetworkUtil();
    final response = await network.post(loginUri, body: body, headers: _defaultHeaders);
    _basicResponseCheck(response);
    return TokenResponse.fromJson(response.result);
  }

  Future<User> signUp(Uri hostUri, String displayName, String email, String password) async {
    final signUpUri = hostUri.resolve('/auth/register');
    final body = {
      'displayName': displayName,
      'email': email,
      'password': password,
    };

    final network = NetworkUtil();
    final response = await network.post(signUpUri, body: body, headers: _defaultHeaders);
    _basicResponseCheck(response);
    return User.fromJson(response.result);
  }

  Future<PageResponse> getBills(Uri hostUri, AccessToken token, {int page = 1}) async {
    final getBillsUri = hostUri.resolve('/bills/page/$page');

    final headers = _makeAuthHeaders(token);

    final network = NetworkUtil();
    final response = await network.get(getBillsUri, headers: headers);
    _basicResponseCheck(response);

    final pageResponse = PageResponse.fromJson(response.result);
    final Map<int, Bill> items = pageResponse.items.isEmpty ?
      {} : Map<int, Bill>.fromEntries(pageResponse.items.map<MapEntry<int, Bill>>((item) {
      final bill = Bill.fromJson(item);
      return MapEntry<int, Bill>(bill.id, bill);
    }));
    return pageResponse.withNewItems(items);
  }

  Future<Bill> addBill(Uri hostUri, AccessToken token, Bill bill) async {
    final addBillUri = hostUri.resolve('/bills/');

    final headers = _makeAuthHeaders(token);
    final body = {
      'billType': bill.type.index + 1,
      'name': bill.name,
      'cost': bill.cost.toStringAsFixed(2),
      'date': bill.date.toUtc().toIso8601String(),
    };

    final network = NetworkUtil();
    final response = await network.post(addBillUri, headers: headers, body: body);
    _basicResponseCheck(response);

    return Bill.fromJson(response.result);
  }

  Future<PageResponse> getBillCycles(Uri hostUri, AccessToken token, Bill bill, {int page = 1}) async {
    final getBillCyclesUri = hostUri.resolve('/bills/${bill.id}/page/$page');

    final headers = _makeAuthHeaders(token);

    final network = NetworkUtil();
    final response = await network.get(getBillCyclesUri, headers: headers);
    _basicResponseCheck(response);

    final pageResponse = PageResponse.fromJson(response.result);
    final Map<int, BillingCycle> items = pageResponse.items.isEmpty ?
      {} : Map<int, BillingCycle>.fromEntries(pageResponse.items.map<MapEntry<int, BillingCycle>>((item) {
        final cycle = BillingCycle.fromJson(item);
        return MapEntry<int, BillingCycle>(cycle.id, cycle);
      }));

    return pageResponse.withNewItems(items);
  }

  Future<PageResponse> getBillPayments(Uri hostUri, AccessToken token, Bill bill, {int page = 1}) async {
    final getBillPaymentsUri = hostUri.resolve('/bills/${bill.id}/payments/page/$page');

    final headers = _makeAuthHeaders(token);

    final network = NetworkUtil();
    final response = await network.get(getBillPaymentsUri, headers: headers);
    _basicResponseCheck(response);

    final pageResponse = PageResponse.fromJson(response.result);
    final Map<int, BillPayment> items = pageResponse.items.isEmpty ?
      {} : pageResponse.items.map<MapEntry<int, BillPayment>>((item) {
        final payment = BillPayment.fromJson(item);
        return MapEntry<int, BillPayment>(payment.id, payment);
    });
    return pageResponse.withNewItems(items);
  }

  Future<PageResponse> getCyclePayments(Uri hostUri, AccessToken token, BillingCycle cycle, {int page = 1}) async {
    final getCyclePaymentsUri = hostUri.resolve('/bills/${cycle.billId}/cycles/${cycle.id}/page/$page');

    final headers = _makeAuthHeaders(token);

    final network = NetworkUtil();
    final response = await network.get(getCyclePaymentsUri, headers: headers);
    _basicResponseCheck(response);

    final pageResponse = PageResponse.fromJson(response.result);
    final Map<int, BillPayment> items = pageResponse.items.isEmpty ?
      {} : pageResponse.items.map<MapEntry<int, BillPayment>>((item) {
        final payment = BillPayment.fromJson(item);
        return MapEntry<int, BillPayment>(payment.id, payment);
    });
    return pageResponse.withNewItems(items);
  }

  Future<PaymentResponse> makeBillPayment(Uri hostUri, AccessToken token, Bill bill, Decimal amount) async {
    final makeBillPaymentUri = hostUri.resolve('/bills/${bill.id}/payments');

    final headers = _makeAuthHeaders(token);
    final body = {
      'amount': amount.toStringAsFixed(2),
    };

    final network = NetworkUtil();
    final response = await network.post(makeBillPaymentUri, headers: headers, body: body);
    _basicResponseCheck(response);
    return PaymentResponse.fromJson(response.result);
  }
}