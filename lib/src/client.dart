import 'enums.dart';
import 'client_stub.dart'
    if (dart.library.html) 'client_browser.dart'
    if (dart.library.io) 'client_io.dart';
import 'response.dart';

abstract class Client {
  late Map<String, String> config;
  late String _endPoint;
  late String _token;

  String get endPoint => _endPoint;

  factory Client(
          {String endPoint = 'http://WAWI01.PFNET.local:8080/4DAction',
          bool selfSigned = false,
          String token = 'ABC'}) =>
      createClient(endPoint: endPoint, selfSigned: selfSigned, token: token);

  Client setToken(String token);

  Client setSelfSigned({bool status = true});

  Client setEndpoint(String endPoint);

  Client addHeader(String key, String value);

  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  });
}
