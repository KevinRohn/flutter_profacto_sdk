enum HttpMethod { get, post, put, delete, patch }

extension HttpMethodString on HttpMethod {
  String name() {
    return this.toString().split('.').last.toUpperCase();
  }
}

enum ResponseType {
  /// content-type of response is "application/json" .
  json,
  plain,
  bytes
}
