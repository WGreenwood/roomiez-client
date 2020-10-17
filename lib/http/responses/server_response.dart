
class ServerResponse {
  final int code;
  final bool success;
  final dynamic result;

  ServerResponse({this.code, this.success, this.result});

  factory ServerResponse.fromJson(dynamic json)
    => ServerResponse(
      code: json['code'] as int,
      success: json['success'] as bool,
      result: json['result']
    );
}