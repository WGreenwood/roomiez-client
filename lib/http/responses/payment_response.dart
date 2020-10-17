

import 'package:roomiez/models/bills/bill.dart';
import 'package:roomiez/models/bills/bill_payment.dart';

class PaymentResponse {
  final Bill bill;
  final BillPayment payment;

  PaymentResponse({this.bill, this.payment});

  factory PaymentResponse.fromJson(dynamic json)
    => PaymentResponse(
      bill: Bill.fromJson(json['bill']),
      payment: BillPayment.fromJson(json['payment'])
    );
}