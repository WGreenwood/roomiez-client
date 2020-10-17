import 'package:decimal/decimal.dart';

class BillPayment {
  final int id;
  final int billId;
  final int cycleId;

  final DateTime timestamp;
  final Decimal amount;

  BillPayment({this.id, this.billId, this.cycleId, this.timestamp, this.amount});

  factory BillPayment.fromJson(dynamic json)
    => json == null ? null : BillPayment(
      id: json['id'],
      billId: json['billId'],
      cycleId: json['cycleId'],
      timestamp: json['timestamp'],
      amount: Decimal.parse(json['amount']),
    );
}
