
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/settings_actions.dart';
import 'package:roomiez/screens/pages.dart';

class _GeneralSettingsViewModel {
  final int startPage;
  final bool useDarkTheme;

  _GeneralSettingsViewModel(this.startPage, this.useDarkTheme);
}

class InterfaceSettingsPage extends StatelessWidget {

  ListTile _buildStartupPageOption(_GeneralSettingsViewModel view)
    => ListTile(
        leading: Icon(Icons.launch),
        title: Text('Startup Page'),
        subtitle: Text('Page to show on Roomiez startup'),
        trailing: DropdownButton<int>(
          onChanged: (val) {
            if (val != view.startPage)
              globals.roomiezStore.dispatch(UpdateStartupPageAction(val));
          },
          value: view.startPage,
          items: Iterable.generate(
            pageBuilders.length,
            (index) => DropdownMenuItem(
              child: Text(pageBuilders[index].title),
              value: index,
            ),
          ).toList(),
        )
      );

  ListTile _buildUseDarkThemeOption(_GeneralSettingsViewModel view)
    => ListTile(
        leading: Icon(Icons.pageview),
        title: Text('Use dark theme'),
        trailing: Checkbox(
          value: view.useDarkTheme,
          onChanged: (val) => globals.roomiezStore.dispatch(UpdateThemeAction(val))
        ),
        onTap: () => globals.roomiezStore.dispatch(UpdateThemeAction(!view.useDarkTheme)),
      );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<RoomiezState, _GeneralSettingsViewModel>(
      converter: (store) => _GeneralSettingsViewModel(
        store.state.startPage,
        store.state.useDarkTheme
      ),
      builder: (context, view) {
        final settingItems = <ListTile>[
          _buildStartupPageOption(view),
          _buildUseDarkThemeOption(view),
        ];

        return Scaffold(
          appBar: AppBar(
            title: Text('Interface Settings'),
          ),
          body: Scrollbar(
            child: ListView.builder(
              itemCount: settingItems.length,
              itemBuilder: (context, index) => settingItems[index],
            ),
          ),
        );
      }
    );
  }
}