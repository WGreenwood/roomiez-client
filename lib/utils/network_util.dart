import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:roomiez/globals.dart' as globals;
import 'package:roomiez/http/responses/server_response.dart';
import 'package:roomiez/models/roomiez_state.dart';
import 'package:roomiez/utils/json_util.dart';

enum HttpMethods {
  Get,
  Post,
  Delete
}

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil._internal();
  NetworkUtil._internal();
  factory NetworkUtil() => _instance;

  static const String userAgent = 'ca.roomiez.android/v1.0';

  Future<HttpClientRequest> _createRequest(HttpClient client, HttpMethods method, Uri uri) {
    Future<HttpClientRequest> futureRequest;
    switch (method) {
      case HttpMethods.Get:
        futureRequest = client.getUrl(uri);
        break;
      case HttpMethods.Post:
        futureRequest = client.postUrl(uri);
        break;
      case HttpMethods.Delete:
        futureRequest = client.deleteUrl(uri);
        break;
      default:
        throw new UnimplementedError();
    }
    if (globals.buildMode == BuildMode.debug)
      return futureRequest;
    return futureRequest.timeout(
      Duration(seconds: 5),
      onTimeout: () {
        client.close(force: true);
        return null;
      },
    );
  }

  Future<ServerResponse> request(HttpMethods method, Uri uri, {Map<String, String> headers = const {}, Map<dynamic, dynamic> body = const {}}) async {
    final JsonUtil jsonUtil = JsonUtil();
    Future<HttpClientResponse> futureResponse;
    try {
      final client = HttpClient();
      client.userAgent = userAgent;

      final request = await _createRequest(client, method, uri);
      if (request == null) return null;

      request.headers.add(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      for (final header in headers.entries)
        request.headers.add(header.key, header.value);

      if (method == HttpMethods.Post)
        request.write(jsonUtil.encode(body));

      futureResponse = request.close();
    } on SocketException catch (ex) {
      debugPrint('socket_send_err{osError: ${ex.osError.errorCode}, method: $method, uri: $uri}');
      return null;
    }
    try {
      if (globals.buildMode != BuildMode.debug)
        futureResponse = futureResponse.timeout(
          Duration(seconds: 5),
          onTimeout: () {
        });
      final response = await futureResponse;
      return await response.transform(utf8.decoder)
        .map(jsonUtil.decode)
        .map((t) => ServerResponse.fromJson(t))
        .first;
    } on SocketException catch (ex) {
      debugPrint('socket_receive_err{osError: ${ex.osError.errorCode}, method: $method, uri: $uri}');
      return null;
    }
  }

  Future<ServerResponse> get(Uri uri, {Map<String, String> headers = const {}})
    => request(HttpMethods.Get, uri, headers: headers);
  Future<ServerResponse> post(Uri uri, {Map<String, String> headers = const {}, Map<dynamic, dynamic> body = const {}})
    => request(HttpMethods.Post, uri, headers: headers, body: body);
  Future<ServerResponse> delete(Uri uri, {Map<String, String> headers = const {}})
    => request(HttpMethods.Delete, uri, headers: headers);
}