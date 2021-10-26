part of flutter_profacto_sdk.models;

class ResponseRecords {
  ResponseRecords({
    required this.totalInQuery,
    required this.offset,
  });
  late final int totalInQuery;
  late final int offset;

  ResponseRecords.fromJson(Map<String, dynamic> json) {
    totalInQuery = json['total_in_query'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_in_query'] = totalInQuery;
    _data['offset'] = offset;
    return _data;
  }
}
