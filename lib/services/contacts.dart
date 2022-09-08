part of flutter_profacto_sdk;

class Contacts extends Service {
  Contacts(ProfactoClient client) : super(client);

  late String _token;

  /// Set token with 'Bestellungen' rights
  Contacts setContactsToken(String token) {
    _token = token;
    return this;
  }

  Future<models.ProfactoResponse> getContactsData({
    required ContactsTable table,
    required String fields,
    String? query,
    int? limit,
    int? offset,
  }) async {
    const String path = '/api_get?/';

    final Map<String, dynamic> params = {
      'table': EnumToString.convertToString(table),
      'fields': fields,
      'query': query,
      'limit': (limit == null) ? 0 : limit,
      'offset': (limit == null) ? 0 : offset,
      'token': _token,
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: path, params: params, headers: headers);
    return models.ProfactoResponse.fromJson(res.data);
  }
}
