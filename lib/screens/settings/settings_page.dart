import 'package:flutter/material.dart';

import 'package:roomiez/globals.dart' as globals;

import 'package:roomiez/screens/settings/interface_settings_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsItemBuilders = <WidgetBuilder>[
      (context) {
        return ListTile(
          leading: Icon(Icons.settings),
          title: Text('Interface'),
          onTap: () {
            globals.navigator.currentState.push(
              MaterialPageRoute(
                builder: (context) => InterfaceSettingsPage(),
              )
            );
          },
        );
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: settingsItemBuilders.length,
          itemBuilder: (context, index) => settingsItemBuilders[index](context),
        ),
      ),
    );
  }
}