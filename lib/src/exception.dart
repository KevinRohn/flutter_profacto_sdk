class ProfactoException implements Exception {
  final String? message;
  final int? code;
  final dynamic response;

  ProfactoException([this.message = "", this.code, this.response]);

  String toString() {
    if (message == null) return "ProfactoException";
    return "ProfactoException: $message (${code ?? 0})";
  }
}
