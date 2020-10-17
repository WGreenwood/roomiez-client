import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:roomiez/globals.dart' as globals;

import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/models/auth/user.dart';
import 'package:roomiez/redux/actions/auth_actions.dart';

import 'package:roomiez/screens/pages.dart';
import 'package:roomiez/screens/settings/settings_page.dart';

class MainPage extends StatelessWidget {
  final HomePageItem _pageItem;

  MainPage(this._pageItem);

  factory MainPage.first() => MainPage.fromBuilder(0);
  factory MainPage.fromBuilder(int index)
    => MainPage(pageBuilders[index]);

  Widget _buildDrawerHeader(BuildContext context, User user) {
    final ThemeData theme = Theme.of(context);
    final body = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.account_circle,
          size: 70,
          color: Colors.white,
        ),
        SizedBox(height: 15),
        Text(user.displayName, style: theme.textTheme.body2.apply(color: Colors.white)),
        SizedBox(height: 5),
        Text(user.email, style: theme.textTheme.body1.apply(color: Colors.white), textScaleFactor: 0.9),
        SizedBox(height: 8),
      ]
    );

    return DrawerHeader(
      decoration: BoxDecoration(
        color: theme.primaryColor
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: body,
            onTap: () {
              print("Goto profile?");
            }
          ),
        ],
      ),
    );
  }
  Widget _buildListTile(String title, IconData icon, void Function() onTap)
    => ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );

  Widget _buildAboutItem(BuildContext context)
    => _buildListTile(
      'About', Icons.info_outline,
      () => showAboutDialog(
          context: context,
          applicationName: globals.applicationName,
          applicationVersion: globals.applicationVersion,
          applicationIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/logo.png'),
            ),
          ),
        ),
    );

  List<Widget> _buildDrawerFooter(BuildContext context)
    => <Widget>[
      Divider(),
      _buildAboutItem(context),
      _buildListTile(
        'Settings', Icons.settings,
        () {
          globals.navigator.currentState
            ..pop()
            ..push(
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              )
            );
        }
      ),
      _buildListTile(
        'Logout', Icons.exit_to_app,
        () => globals.roomiezStore.dispatch(logout()))
    ];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<RoomiezState, User>(
      converter: (store) => store.state.auth.currentUser,
      builder: (context, user) {
        final appBar = AppBar(
          title: Text(_pageItem.title),
          actions: _pageItem.buildAppBarButton != null ? <Widget>[
            _pageItem?.buildAppBarButton(context),
          ] : <Widget>[],
        );
        final fab = _pageItem.buildFab?.call(context);
        final body = _pageItem.buildWidget(context);

        final drawerBody = Expanded(
          child: Scrollbar(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: pageBuilders.length,
              itemBuilder: (context, index) {
                final item = pageBuilders[index];
                final onTap = identical(item, _pageItem)
                  ? () => globals.navigator.currentState.pop()
                  : () {
                    final nav = globals.navigator.currentState;
                    nav.pop();
                    nav.push(MaterialPageRoute(builder: (context) => MainPage(item)));
                  };
                return _buildListTile(item.title, item.drawerIcon, onTap);
              },
            ),
          ),
        );

        final drawer = Drawer(
          elevation: 2,
          child: Column(
            children: <Widget>[
              _buildDrawerHeader(context, user),
              drawerBody,
            ]..addAll(_buildDrawerFooter(context)),
          ),
        );

        return Scaffold(
          appBar: appBar,
          floatingActionButton: fab,
          drawer: drawer,
          body: body
        );
      }
    );
  }
}