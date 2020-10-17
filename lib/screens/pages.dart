
import 'package:flutter/material.dart';
import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/redux/actions/bill_actions.dart';
import 'package:roomiez/screens/bills/add_bill_page.dart';
import 'package:roomiez/screens/bills/bills_page.dart';
import 'package:roomiez/screens/construction/construction_page.dart';
import 'package:roomiez/screens/household/household_page.dart';

class HomePageItem {
  final String title;
  final IconData drawerIcon;
  final WidgetBuilder buildFab;
  final WidgetBuilder buildWidget;
  final WidgetBuilder buildAppBarButton;

  HomePageItem({this.title, this.drawerIcon, this.buildFab, this.buildWidget, this.buildAppBarButton});
}

final pageBuilders = <HomePageItem>[
  HomePageItem(
    title: 'Roomiez',
    drawerIcon: Icons.people,
    buildWidget: (context) => HouseholdPage(),
    buildFab: (context) => FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Add Person'),
      heroTag: 'fab',
      elevation: 3,
      onPressed: () {
        print('Add Person');
      },
    ),
  ),
  HomePageItem(
    title: 'Bills',
    drawerIcon: Icons.attach_money,
    buildWidget: (context) => BillsPage(),
    buildFab: (context) => FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Add Bill'),
      heroTag: 'fab',
      elevation: 3,
      onPressed: () {
        globals.navigator.currentState.push(
          MaterialPageRoute(
            builder: (context) => AddBillPage()
          )
        );
      },
    ),
    buildAppBarButton: (context) => IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        globals.roomiezStore.dispatch(
          getBillsRequest(page: 0, clearStoreBefore: true)
        );
      },
    )
  ),
  HomePageItem(
    title: 'Group Chat',
    drawerIcon: Icons.message,
    buildWidget: (context) => UnderConstructionPage(),
    buildFab: (context) => FloatingActionButton.extended(
      icon: Icon(Icons.message),
      label: Text('New Thread'),
      tooltip: 'Test',
      heroTag: 'fab',
      elevation: 3,
      onPressed: () {
        print('New chat thread');
      },
    ),
  ),
  HomePageItem(
    title: 'Shopping List',
    drawerIcon: Icons.shopping_cart,
    buildWidget: (context) => UnderConstructionPage(),
    buildFab: (context) => FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Add List'),
      heroTag: 'fab',
      elevation: 3,
      onPressed: () {
        print('Add shopping list');
      },
    ),
  ),
  HomePageItem(
    title: 'Chores',
    drawerIcon: Icons.home,
    buildWidget: (context) => UnderConstructionPage(),
    buildFab: (context) => FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Add Chore'),
      heroTag: 'fab',
      elevation: 3,
      onPressed: () {},
    ),
  ),
  HomePageItem(
    title: 'Notes',
    drawerIcon: Icons.note,
    buildWidget: (context) => UnderConstructionPage(),
    buildFab: (context) => FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Add Note'),
      heroTag: 'fab',
      elevation: 3,
      onPressed: () {},
    ),
  ),
];
