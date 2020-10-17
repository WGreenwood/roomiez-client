import 'package:roomiez/models/auth/access_token.dart';
import 'package:roomiez/models/auth/user.dart';

class AuthState {
  static final Object _nullLastErrorResult = new Object();
  static Object get nullLastErrorResult => _nullLastErrorResult;

  final AccessToken accessToken;
  final User currentUser;

  AuthState({this.accessToken, this.currentUser});

  factory AuthState.initial()
    => AuthState(
      accessToken: AccessToken.nullInstance,
      currentUser: User.nullInstance,
    );

  AuthState clone({AccessToken accessToken, User currentUser})
    => AuthState(
      accessToken: accessToken ?? this.accessToken,
      currentUser: currentUser ?? this.currentUser,
    );

  bool isAuthenticated()
    => currentUser.isNotNull()
    && accessToken.isNotNull()
    && DateTime.now().toUtc().isBefore(accessToken.expires);

  static AuthState fromJson(dynamic json)
    => AuthState(
      accessToken: AccessToken.fromJson(json['accessToken']),
      currentUser: User.fromJson(json['currentUser']),
    );

  dynamic toJson()
    => {
      'accessToken': accessToken.toJson(),
      'currentUser': currentUser.toJson()
    };

  @override
  String toString()
    => 'AuthState{accessToken: $accessToken, currentUser: $currentUser}';
}