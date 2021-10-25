import 'response.dart';
import 'client.dart';
import 'enums.dart';

abstract class ClientBase implements ProfactoClient {
  @override
  ClientBase setSelfSigned({bool status = true});
  @override
  ClientBase setEndpoint(String endPoint);
  @override
  ClientBase addHeader(String key, String value);

  @override
  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  });
}
