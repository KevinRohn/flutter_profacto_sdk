part of flutter_profacto_sdk.models;

class ResponseRecords {
  final int totalInQuery;
  final int offset;

  ResponseRecords({required this.totalInQuery, required this.offset});

  factory ResponseRecords.fromMap(Map<String, dynamic> map) {
    return ResponseRecords(
        totalInQuery: map['total_in_query'], offset: map['offset']);
  }

  Map<String, dynamic> toMap() {
    return {
      "total_in_query": totalInQuery,
      "offset": offset,
    };
  }
}
