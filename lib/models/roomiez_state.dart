import 'package:roomiez/models/auth/auth_state.dart';
import 'package:roomiez/models/bills/bill.dart';
enum BuildMode {
  release, profile, debug
}
class RoomiezState {
  final int startPage;
  final bool isLoading;
  final bool useDarkTheme;
  final String lastEmail;
  final String hostAddress;
  final AuthState auth;
  final Map<int, Bill> bills;

  Uri get hostUri => Uri.parse('http://$hostAddress');

  RoomiezState({this.startPage, this.isLoading, this.useDarkTheme, this.lastEmail, this.hostAddress, this.auth, this.bills});

  RoomiezState clone({int startPage, bool isLoading, bool useDarkTheme, String lastEmail, String hostAddress, AuthState auth, Map<int, Bill> bills})
    => RoomiezState(
      startPage: startPage ?? this.startPage,
      isLoading: isLoading ?? this.isLoading,
      useDarkTheme: useDarkTheme ?? this.useDarkTheme,
      lastEmail: lastEmail ?? this.lastEmail,
      hostAddress: hostAddress ?? this.hostAddress,
      auth: auth ?? this.auth.clone(),
      bills: bills != null ? Map.unmodifiable(bills) : this.bills
    );

  factory RoomiezState.initial()
    => RoomiezState(
      startPage: 0,
      isLoading: false,
      useDarkTheme: false,
      hostAddress: '10.0.2.2:5000',
      auth: AuthState.initial(),
      bills: Map.unmodifiable({}),
    );

  static RoomiezState fromJson(dynamic json)
  {
    if (json == null) return null;
    return RoomiezState(
      startPage: json['startPage'],
      isLoading: false,
      useDarkTheme: json['useDarkTheme'],
      lastEmail: json['lastEmail'],
      hostAddress: json['hostAddress'],
      auth: AuthState.fromJson(json['auth']),
      bills: Map.unmodifiable({}),
    );
  }

  dynamic toJson()
    => {
      'startPage': startPage,
      'useDarkTheme': useDarkTheme,
      'hostAddress': hostAddress,
      'lastEmail': lastEmail,
      'auth': auth.toJson(),
    };


  @override
  String toString()
    => 'RoomiezState{startPage: $startPage, isLoading: $isLoading, useDarkTheme: $useDarkTheme, hostAddress: $hostAddress, auth: $auth, bills: $bills}';
}