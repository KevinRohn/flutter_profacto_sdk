part of flutter_profacto_sdk;

class Projects extends Service {
  Projects(ProfactoClient client) : super(client);

  late String _token;

  /// Set token with 'Projects' rights
  ///
  /// See documentation: https://conf.extragroup.de/display/handbuch/API+-+Projekte
  Projects setProjectsToken(String token) {
    _token = token;
    return this;
  }

  /// Get Project related data
  ///
  /// The method returns data from a given table, which is related to the 'projects' API.
  ///
  /// Allowed tables are defined in the [table] enum.
  /// Use a comma separated list for the selected [fields]. (e.g: 'AuftragsNr,Bauvorhaben').
  ///
  Future<models.ProfactoResponse> getProjectData({
    required ProjectTable table,
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
