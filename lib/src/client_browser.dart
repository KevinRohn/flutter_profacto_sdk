import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';
import 'client_mixin.dart';
import 'enums.dart';
import 'exception.dart';
import 'client_base.dart';

import 'response.dart';

ClientBase createClient({required String endPoint, required bool selfSigned}) =>
    ClientBrowser(endPoint: endPoint, selfSigned: selfSigned);

class ClientBrowser extends ClientBase with ClientMixin {
  String _endPoint;
  Map<String, String>? _headers;
  @override
  late Map<String, String> config;
  late BrowserClient _httpClient;

  ClientBrowser(
      {String endPoint = 'https://myServer.de:8080/4DAction/',
      bool selfSigned = false})
      : _endPoint = endPoint {
    _httpClient = BrowserClient();
    _headers = {
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };

    config = {};

    assert(_endPoint.startsWith(RegExp("http://|https://")),
        "endPoint $_endPoint must start with 'http'");
    init();
  }

  @override
  String get endPoint => _endPoint;

  @override
  ClientBrowser setSelfSigned({bool status = true}) {
    return this;
  }

  @override
  ClientBrowser setEndpoint(String endPoint) {
    _endPoint = endPoint;
    return this;
  }

  @override
  ClientBrowser addHeader(String key, String value) {
    _headers![key] = value;

    return this;
  }

  Future init() async {
    _httpClient.withCredentials = true;
  }

  @override
  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  }) async {
    await init();

    late http.Response res;

    http.BaseRequest request = prepareRequest(
      method,
      uri: Uri.parse(_endPoint + path),
      headers: {..._headers!, ...headers},
      params: params,
    );
    try {
      print(request.url);
      final streamedResponse = await _httpClient.send(request);
      res = await toResponse(streamedResponse);

      return prepareResponse(res, responseType: responseType);
    } catch (e) {
      if (e is ProfactoException) {
        rethrow;
      }
      throw ProfactoException(e.toString());
    }
  }
}
