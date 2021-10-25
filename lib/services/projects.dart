part of flutter_profacto_sdk;

class Projects extends Service {
  Projects(Client client) : super(client);

  Future<void> getProjet() async {
    final String path = '/api_get?/';

    final Map<String, dynamic> params = {
      'table': 'Auftrag',
      'fields': 'AuftragsNr'
    };

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };
    final res = await client.call(HttpMethod.get,
        path: path, params: params, headers: headers);
  }
}
