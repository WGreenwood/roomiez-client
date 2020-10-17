
import 'package:flutter/material.dart';

@immutable
class AccessToken {
  static final AccessToken _nullInstance = AccessToken();
  static AccessToken get nullInstance => _nullInstance;

  final DateTime expires;
  final String value;

  AccessToken({this.expires, this.value});

  bool isNull() => identical(this, nullInstance);
  bool isNotNull() => !isNull();

  static AccessToken fromJson(Map<String, dynamic> json)
    => json.isEmpty
    ? AccessToken.nullInstance
    : AccessToken(
      expires: DateTime.parse(json['expires']),
      value: json['value'],
    );

  Map<String, dynamic> toJson()
    => isNull() ? {} : {
      'expires': expires?.toIso8601String(),
      'value': value
    };

  @override
  String toString()
    => isNull() ? 'AccessToken{null}'
    : 'AccessToken{expires: $expires}';
}