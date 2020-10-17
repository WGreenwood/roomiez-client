

import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';

import 'package:roomiez/models/roomiez_state.dart';

const String applicationName = 'Roomiez';
const String applicationVersion = '0.5.0';

final navigator = GlobalKey<NavigatorState>();

Store<RoomiezState> roomiezStore;
Persistor<RoomiezState> roomiezPersistor;

BuildMode buildMode = (() {
  if (const bool.fromEnvironment('dart.vm.product')) {
    return BuildMode.release;
  }
  var result = BuildMode.profile;
  assert(() {
    result = BuildMode.debug;
    return true;
  }());
  return result;
}());