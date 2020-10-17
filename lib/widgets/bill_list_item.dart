import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/models/bills/bill.dart';
import 'package:roomiez/models/bills/bill_type.dart';
import 'package:roomiez/screens/bills/bill_details_page.dart';

class BillListItem extends StatelessWidget {
  final Bill bill;

  BillListItem({this.bill});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black;
    final boldTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: textColor
    );
    final currencyFormatter = NumberFormat.simpleCurrency();
    return Material(
      type: MaterialType.card,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      elevation: 3,
      child: ListTile(
        onTap: () {
          globals.navigator.currentState.push(
            MaterialPageRoute(
              builder: (context) => BillDetailsPage(bill)
            )
          );
        },
        key: Key(bill.id.toString()),
        title: Text(bill.name, style: boldTextStyle),
        leading: Hero(
          tag: 'bill_${bill.id}',
          child: CircleAvatar(
            child: Text(
              billTypeIdentifiers[bill.type],
              textScaleFactor: 1.5,
            ),
            radius: 25,
          ),
        ),
        // isThreeLine: true,
        trailing: Text(
          currencyFormatter.format(
            bill.currentCycle.remainingCost.toDouble()
          ),
          style: boldTextStyle,
        ),
        subtitle: RichText(
          text: TextSpan(
            style: boldTextStyle,
            children: <TextSpan>[
              TextSpan(
                text: currencyFormatter.format(
                  bill.currentCycle.paidAmount.toDouble(),
                ),
              ),
              TextSpan(
                text: ' / '
              ),
              TextSpan(
                text: currencyFormatter.format(
                  bill.cost.toDouble()
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}