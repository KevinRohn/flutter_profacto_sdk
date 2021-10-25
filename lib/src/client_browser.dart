import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';
import 'client_mixin.dart';
import 'enums.dart';
import 'exception.dart';
import 'client_base.dart';

import 'response.dart';

ClientBase createClient({
  required String endPoint,
  required bool selfSigned,
  required String token,
}) =>
    ClientBrowser(endPoint: endPoint, selfSigned: selfSigned, token: token);

class ClientBrowser extends ClientBase with ClientMixin {
  String _endPoint;
  late String _token;
  Map<String, String>? _headers;
  late Map<String, String> config;
  late BrowserClient _httpClient;

  ClientBrowser(
      {String endPoint = 'https://myServer.de:8080/4DAction/',
      bool selfSigned = false,
      String token = 'ABC'})
      : _endPoint = endPoint {
    _httpClient = BrowserClient();
    _headers = {
      'content-type': 'application/json',
      'x-sdk-version': 'profacto:flutter:2.0.3',
      'X-Profacto-Response-Format': '0.11.0',
    };

    this.config = {};

    assert(_endPoint.startsWith(RegExp("http://|https://")),
        "endPoint $_endPoint must start with 'http'");
    init();
  }

  String get endPoint => _endPoint;

  ClientBrowser setToken(value) {
    this._token = value;
    return this;
  }

  ClientBrowser setSelfSigned({bool status = true}) {
    return this;
  }

  ClientBrowser setEndpoint(String endPoint) {
    this._endPoint = endPoint;
    return this;
  }

  ClientBrowser addHeader(String key, String value) {
    _headers![key] = value;

    return this;
  }

  Future init() async {
    _httpClient.withCredentials = true;
  }

  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  }) async {
    await this.init();

    late http.Response res;
    http.BaseRequest request = this.prepareRequest(
      method,
      uri: Uri.parse(_endPoint + path + '&token=' + _token),
      headers: {...this._headers!, ...headers},
      params: params,
    );
    try {
      final streamedResponse = await _httpClient.send(request);
      res = await toResponse(streamedResponse);

      return this.prepareResponse(res, responseType: responseType);
    } catch (e) {
      if (e is ProfactoException) {
        rethrow;
      }
      throw ProfactoException(e.toString());
    }
  }
}
