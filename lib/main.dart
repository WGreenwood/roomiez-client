import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/data/theme.dart' as theme;
import 'package:roomiez/models/roomiez_state.dart';

import 'package:roomiez/redux/store.dart';

import 'package:roomiez/screens/auth/auth_page.dart';
import 'package:roomiez/screens/main_page.dart';

void main() async {
  globals.roomiezPersistor = createPersistor();
  globals.roomiezStore = await createStore();
  runApp(RoomiezApp());
}

class _InitialViewModel {
  final bool useDarkTheme;
  final bool isAuthenticated;
  final int startPage;

  _InitialViewModel(this.useDarkTheme, this.isAuthenticated, this.startPage);
}

class RoomiezApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    StoreProvider(
      store: globals.roomiezStore,
      child: StoreConnector<RoomiezState, _InitialViewModel>(
        converter: (store) => _InitialViewModel(
            store.state.useDarkTheme,
            store.state.auth.isAuthenticated(),
            store.state.startPage
        ),
        builder: (context, view) => MaterialApp(
          title: 'Roomiez',
          theme: view.useDarkTheme ? theme.dark : theme.light,
          navigatorKey: globals.navigator,
          routes: {
            '/': (BuildContext context) => view.isAuthenticated
                  ? MainPage.fromBuilder(view.startPage)
                  : AuthPage.login(),
            '/login': (context) => AuthPage.login(),
            '/signup': (context) => AuthPage.signup(),
            '/home': (context) => MainPage.fromBuilder(view.startPage),
          },
        ),
      ),
    );
}
