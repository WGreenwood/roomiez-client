
import 'package:decimal/decimal.dart';
import 'package:roomiez/models/bills/bill_type.dart';
import 'package:roomiez/models/bills/billing_cycle.dart';

class Bill {
  final int id;
  final String name;
  final BillType type;
  final Decimal cost;
  final DateTime date;
  final BillingCycle currentCycle;

  Bill({this.id, this.name, this.type, this.cost, this.date, this.currentCycle});

  factory Bill.fromJson(dynamic json)
    => Bill(
      id: json['id'],
      name: json['name'],
      type: billTypeMap[json['type']],
      cost: Decimal.parse(json['cost']),
      date: DateTime.parse(json['date']),
      currentCycle: BillingCycle.fromJson(json['cycle']),
    );

  @override
  String toString()
    => "Bill<id: $id, name: $name, cost: $cost, type: $type>";
}