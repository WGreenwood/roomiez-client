
class ServerResponseException implements Exception {
  final int errorCode;
  final dynamic errorData;
  ServerResponseException({this.errorCode, this.errorData});
}