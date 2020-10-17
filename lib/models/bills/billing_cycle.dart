import 'package:decimal/decimal.dart';

class BillingCycle {
  final int id;
  final int billId;
  final Decimal cost;
  final DateTime startDate;
  final DateTime endDate;

  final bool isOver;
  final bool isPaid;
  final Decimal paidAmount;
  final Decimal remainingCost;

  BillingCycle({
    this.id, this.billId, this.cost, this.startDate, this.endDate,
    this.isOver, this.isPaid, this.paidAmount, this.remainingCost
  });

  factory BillingCycle.fromJson(dynamic json)
    => json == null ? null : BillingCycle(
      id: json['id'],
      billId: json['billId'],
      cost: Decimal.parse(json['cost']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),

      isOver: json['isOver'],
      isPaid: json['isPaid'],
      paidAmount: Decimal.parse(json['paidAmount']),
      remainingCost: Decimal.parse(json['remainingCost']),
    );
}