part of flutter_profacto_sdk;

class Orders extends Service {
  Orders(ProfactoClient client) : super(client);

  late String _token;

  /// Set token with 'Bestellungen' rights
  Orders setOrdersToken(String token) {
    _token = token;
    return this;
  }

  Future<models.ProfactoResponse> getOrderData({
    required OrdersTable table,
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

  Future<models.ProfactoResponse> setOrderPositionAutoAppend(
      {required String orderNote,
      required String articleId,
      required int amount}) async {
    const String path = '/api_put_bestellpos?/';
    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final Map<String, dynamic> params = {
      'token': _token,
      'append': 'True',
      'table': EnumToString.convertToString(OrdersTable.Bestellung),
      'BestellNr': 0,
      'LfdNr': 0,
      'BestellMenge': amount,
      'ArtikelNr': articleId,
      'Bemerkung': orderNote
    };
    final res = await client.call(HttpMethod.get,
        path: path, params: params, headers: headers);

    return res.data;
  }
}
