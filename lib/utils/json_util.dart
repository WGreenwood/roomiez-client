import 'dart:convert';

class JsonUtil {
  static final JsonUtil _instance = JsonUtil._internal();
  JsonUtil._internal();
  factory JsonUtil() => _instance;

  final JsonEncoder _encoder = new JsonEncoder();
  final JsonDecoder _decoder = new JsonDecoder();

  String encode(Object value) => _encoder.convert(value);
  dynamic decode(String json) => _decoder.convert(json);
}