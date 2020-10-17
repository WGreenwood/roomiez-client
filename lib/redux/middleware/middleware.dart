

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/redux/middleware/navigation_middleware.dart';


List<Middleware<RoomiezState>> createMiddleware() => <Middleware<RoomiezState>>[
    thunkMiddleware,
    navigationMiddleware,
    globals.roomiezPersistor.createMiddleware(),
    LoggingMiddleware.printer(),
];