import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/http/error_codes.dart';
import 'package:roomiez/models/bills/bill_type.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/bill_actions.dart';
import 'package:roomiez/widgets/widgets.dart';

class AddBillPage extends StatefulWidget {
  @override
  _AddBillPageState createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cycleStartTextBox = new TextEditingController();

  String _billName;
  BillType _billType;
  DateTime _cycleStart;
  String _cost;

  Widget _buildBillTypeInput(bool isLoading) => Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: DropdownButtonFormField<BillType>(
          items: isLoading
              ? []
              : Iterable.generate(billTypeStrings.length).map((index) {
                  final item = billTypeStrings.entries.elementAt(index);
                  return DropdownMenuItem<BillType>(
                    child: Text(item.value),
                    value: item.key,
                  );
                }).toList(),
          onChanged:
              isLoading ? null : (value) => setState(() => _billType = value),
          value: _billType,
          hint: isLoading
              ? Text(billTypeStrings[_billType])
              : Text(' '),
          validator: (val) => val == null ? "A bill type is required" : null,
          decoration: InputDecoration(
            labelText: 'Bill Type',
            hasFloatingPlaceholder: true,
            contentPadding:
                const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            prefixIcon: Icon(Icons.schedule),
          ),
        ),
      );

  Widget _buildCurrentCycleInput(bool isLoading) => GestureDetector(
      onTap: () async {
        final cycleStart = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2018),
          lastDate: DateTime(2025),
        );
        if (cycleStart != null) {
          _cycleStartTextBox.text = DateFormat.yMMMd().format(cycleStart);
          _cycleStart = DateTime(cycleStart.year, cycleStart.month, cycleStart.day);
        }
      },
      child: AbsorbPointer(
        child: TextFormFieldWrap(
            labelText: 'Current Cycle Start',
            prefixIcon: Icons.event,
            inputType: TextInputType.datetime,
            enabled: !isLoading,
            controller: _cycleStartTextBox,
            validator: (value) => value.isEmpty ? 'Select a date' : null),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new bill'),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text('New Bill',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1),
              SizedBox(height: 76),
              StoreConnector<RoomiezState, bool>(
                converter: (state) => state.state.isLoading,
                builder: (context, isLoading) => Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormFieldWrap(
                        labelText: "Bill Name",
                        prefixIcon: Icons.description,
                        onSaved: (value) => _billName = value,
                        enabled: !isLoading,
                        validator: (value) =>
                            value.isEmpty ? 'Bill Name is required' : null,
                      ),
                      _buildCurrentCycleInput(isLoading),
                      TwoColumnRow(
                        leftChild: CostTextFormField(
                          enabled: !isLoading,
                          onSaved: (value) => _cost = value,
                        ),
                        rightChild: _buildBillTypeInput(isLoading),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButtonWrap(
                              text: 'Create',
                              icon: Icons.add,
                              onPressed: () {
                                final formState = _formKey.currentState;
                                if (!formState.validate()) return;
                                formState.save();
                                globals.roomiezStore.dispatch(addBillRequest(
                                  name: _billName,
                                  billType: _billType,
                                  currentCycleStart: _cycleStart,
                                  cost: Decimal.parse(_cost),
                                  onError: (code, data) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(ErrorCodes.English[code])));
                                  }
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      ProgressRing(enabled: isLoading),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
    );
  }
}
