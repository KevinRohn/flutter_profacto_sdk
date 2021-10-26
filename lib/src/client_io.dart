import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'client_mixin.dart';
import 'client_base.dart';
import 'enums.dart';
import 'exception.dart';
import 'interceptor.dart';
import 'response.dart';

ClientBase createClient({required String endPoint, required bool selfSigned}) =>
    ClientIO(
      endPoint: endPoint,
      selfSigned: selfSigned,
    );

class ClientIO extends ClientBase with ClientMixin {
  String _endPoint;
  Map<String, String>? _headers;
  late Map<String, String> config;
  bool selfSigned;
  bool _initialized = false;
  late http.Client _httpClient;
  late HttpClient _nativeClient;
  late CookieJar _cookieJar;
  List<Interceptor> _interceptors = [];

  bool get initialized => _initialized;
  CookieJar get cookieJar => _cookieJar;

  ClientIO(
      {String endPoint = 'https://myServer.de:8080/4DAction/',
      this.selfSigned = false})
      : _endPoint = endPoint {
    _nativeClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => selfSigned);
    _httpClient = new IOClient(_nativeClient);
    _headers = {
      'content-type': 'application/json',
      'x-sdk-version': 'profacto:flutter:2.0.3',
      'X-Profacto-Response-Format': '0.11.0',
    };

    config = {};

    assert(_endPoint.startsWith(RegExp("http://|https://")),
        "endPoint $_endPoint must start with 'http'");
    init();
  }

  @override
  String get endPoint => _endPoint;

  @override
  ClientIO setSelfSigned({bool status = true}) {
    selfSigned = status;
    _nativeClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => status);
    return this;
  }

  @override
  ClientIO setEndpoint(String endPoint) {
    _endPoint = endPoint;
    return this;
  }

  @override
  ClientIO addHeader(String key, String value) {
    _headers![key] = value;

    return this;
  }

  Future init() async {
    // if web skip cookie implementation and origin header as those are automatically handled by browsers
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    addHeader('Origin',
        'profacto-${Platform.operatingSystem}://${packageInfo.packageName}');

    //creating custom user agent
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    var device = '';
    if (Platform.isAndroid) {
      final andinfo = await deviceInfoPlugin.androidInfo;
      device =
          '(Linux; U; Android ${andinfo.version.release}; ${andinfo.brand} ${andinfo.model})';
    }
    if (Platform.isIOS) {
      final iosinfo = await deviceInfoPlugin.iosInfo;
      device = '${iosinfo.utsname.machine} iOS/${iosinfo.systemVersion}';
    }
    if (Platform.isLinux) {
      final lininfo = await deviceInfoPlugin.linuxInfo;
      device = '(Linux; U; ${lininfo.id} ${lininfo.version})';
    }
    if (Platform.isWindows) {
      final wininfo = await deviceInfoPlugin.windowsInfo;
      device = '(Windows NT; ${wininfo.computerName})';
    }
    if (Platform.isMacOS) {
      final macinfo = await deviceInfoPlugin.macOsInfo;
      device = '(Macintosh; ${macinfo.model})';
    }
    addHeader('user-agent',
        '${packageInfo.packageName}/${packageInfo.version} $device');

    _initialized = true;
  }

  Future<http.BaseRequest> _interceptRequest(http.BaseRequest request) async {
    final body = (request is http.Request) ? request.body : '';
    for (final i in _interceptors) {
      if (i is Interceptor) {
        request = await i.onRequest(request);
      }
    }

    if (request is http.Request) {
      assert(
        body == request.body,
        'Interceptors should not transform the body of the request'
        'Use Request converter instead',
      );
    }
    return request;
  }

  Future<http.Response> _interceptResponse(http.Response response) async {
    final body = response.body;
    for (final i in _interceptors) {
      if (i is Interceptor) {
        response = await i.onResponse(response);
      }
    }

    assert(
      body == response.body,
      'Interceptors should not transform the body of the response',
    );
    return response;
  }

  @override
  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  }) async {
    if (!_initialized) {
      await init();
    }

    late http.Response res;
    http.BaseRequest request = prepareRequest(
      method,
      uri: Uri.parse(_endPoint + path),
      headers: {...this._headers!, ...headers},
      params: params,
    );

    try {
      request = await _interceptRequest(request);
      final streamedResponse = await _httpClient.send(request);
      res = await toResponse(streamedResponse);
      res = await _interceptResponse(res);

      return prepareResponse(
        res,
        responseType: responseType,
      );
    } catch (e) {
      if (e is ProfactoException) {
        rethrow;
      }
      throw ProfactoException(e.toString());
    }
  }
}
