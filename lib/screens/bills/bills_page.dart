
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/http/error_codes.dart';
import 'package:roomiez/http/responses/page_response.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/bill_actions.dart';
import 'package:roomiez/screens/bills/view_model.dart';
import 'package:roomiez/widgets/bill_list_item.dart';

class BillsPage extends StatefulWidget {
  @override
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  final ScrollController _scrollController = ScrollController();

  int _nextPage = 0;
  PageResponse response;

  void _getPage() {
    globals.roomiezStore.dispatch(
      getBillsRequest(
        page: _nextPage,
        responseOut: (response) => this.response = response,
        clearStoreBefore: response == null,
        onError: (code, data) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(ErrorCodes.English[code])
          ));
        }
      )
    );
    ++_nextPage;
  }

  @override
  void initState() {
    super.initState();
    _getPage();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==_scrollController.position.maxScrollExtent && !globals.roomiezStore.state.isLoading) {
        _getPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StoreConnector<RoomiezState, BillsPageViewModel>(
      converter: (store) => BillsPageViewModel(
        isLoading: store.state.isLoading,
        bills: store.state.bills
      ),
      builder: (context, view) {
        final children = <Widget>[];

        if (view.isLoading)
          children.add(LinearProgressIndicator(
            backgroundColor: Colors.transparent,
          ));

        if (!view.isLoading && view.bills.isEmpty)
          children.add(
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'No bills added',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title
              ),
            ),
          );

        children.add(
          ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            controller: _scrollController,
            itemCount: view.bills.length,
            itemBuilder: (context, index) {
              final key = view.bills.keys.elementAt(index);
              final value = view.bills[key];
              return Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: BillListItem(bill: value)
              );
            }
          ),
        );

        return RefreshIndicator(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: children,
          ),
          onRefresh: () {
            _nextPage = 0;
            _getPage();
            return Future.doWhile(()
              => view.isLoading
            );
          },
        );
      },
    );
  }
}