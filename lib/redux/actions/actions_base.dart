
import 'package:flutter/material.dart';

class RemovePageAction {}
class NavigationAction {
  final String path;
  final bool replace;

  NavigationAction({
    @required this.path,
    @required this.replace,
  });
}

class StartLoadingAction {}
class EndLoadingAction {}