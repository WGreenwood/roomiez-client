

import 'package:flutter/material.dart';
import 'package:roomiez/models/bills/bill.dart';
import 'package:roomiez/models/bills/bill_type.dart';

class BillDetailsPage extends StatelessWidget {
  final Bill _bill;
  // TODO: Switch to passing bill id for if the bill changes in the state
  BillDetailsPage(this._bill);

  Widget _buildDetail(TextStyle style, String leftText, String rightText)
    => Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: style,
                text: leftText
              ),
            ),
            Expanded(flex: 1, child: const Text('')),
            RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                style: style,
                text: rightText
              ),
            ),
          ],
        ),
      ),
    );

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black;
    final textStyle = TextStyle(
      color: textColor
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "'${_bill.name}' bill"
        ),
      ),
      floatingActionButton: _bill.currentCycle.isPaid
        ? null
        : Hero(
          tag: 'fab',
          child: FloatingActionButton.extended(
            label: Text('Make Payment'),
            icon: Icon(Icons.attach_money),
            onPressed: () {},
          ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            SizedBox(height: 38),
            Hero(
              tag: 'bill_${_bill.id}',
              child: CircleAvatar(
                child: Text(
                  billTypeIdentifiers[_bill.type],
                  textScaleFactor: 2.5,
                ),
                radius: 45,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _bill.name,
              style: Theme.of(context).textTheme.display1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Expanded(
              flex: 1,
                child: Container(
                  child: ListView(
                    semanticChildCount: 55,
                    children: <Widget>[
                      _buildDetail(textStyle, 'Bill Type', billTypeStrings[_bill.type]),
                      _buildDetail(textStyle, 'Total Cost', '\$${_bill.cost.toStringAsFixed(2)}'),
                      _buildDetail(textStyle, 'Paid Amount', '\$${_bill.currentCycle.paidAmount.toStringAsFixed(2)}'),
                      _buildDetail(textStyle, 'Remaining Cost', '\$${_bill.currentCycle.remainingCost.toStringAsFixed(2)}'),
                      _buildDetail(textStyle, 'Days left in cycle', _bill.currentCycle.endDate.difference(DateTime.now()).inDays.toString()),
                    ],
                  ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}