import 'package:roomiez/models/auth/access_token.dart';
import 'package:roomiez/models/auth/user.dart';

class TokenResponse {
  String accessToken;
  User user;
  DateTime expires;
  TokenResponse({this.accessToken, this.user, this.expires});

  AccessToken get tokenInstance => AccessToken(
    expires: expires,
    value: accessToken
  );

  factory TokenResponse.fromJson(dynamic json)
    => TokenResponse(
      accessToken: json['jwt'],
      user: User.fromJson(json['user']),
      expires: DateTime.parse(json['expires']),
    );
}