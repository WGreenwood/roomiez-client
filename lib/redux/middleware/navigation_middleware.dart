import 'package:redux/redux.dart';
import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/actions/actions_base.dart';

void navigationMiddleware(
  Store<RoomiezState> store,
  dynamic action,
  NextDispatcher next
) {
  next(action);
  if (action is NavigationAction) {
    final NavigationAction navAction = action;
    final navState = globals.navigator.currentState;
    if (navAction.replace)
      navState.pushReplacementNamed(navAction.path);
    else
      globals.navigator.currentState.pushNamed(navAction.path);
  } else if (action is RemovePageAction) {
    globals.navigator.currentState.pop();
  }
}
