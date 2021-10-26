part of flutter_profacto_sdk.models;

class ProfactoResponse {
  final String error;
  final bool success;
  final int startProcess;
  final String responseMode;
  final bool licenseOK;
  final List<String> structureAccessInfo;
  final Map<List, dynamic> auftrag;
  final ResponseRecords records;
  final int endProcess;
  final int processingTime;
  final String errorMsg;

  ProfactoResponse({
    required this.error,
    required this.success,
    required this.startProcess,
    required this.responseMode,
    required this.licenseOK,
    required this.structureAccessInfo,
    required this.auftrag,
    required this.records,
    required this.endProcess,
    required this.processingTime,
    required this.errorMsg,
  });

  factory ProfactoResponse.fromMap(Map<String, dynamic> map) {
    return ProfactoResponse(
        error: map['error'],
        success: map['success'],
        startProcess: map['startProcess'],
        responseMode: map['responseMode'],
        licenseOK: map['licenseOk'],
        structureAccessInfo: map['structure_access_info'],
        records: ResponseRecords.fromMap(map['records']),
        endProcess: map['endProcess'],
        processingTime: map['processingTime'],
        auftrag: map['Auftrag'],
        errorMsg: map['errorMsg']);
  }

  Map<String, dynamic> toMap() {
    return {
      "error": error,
      "success": success,
      "startProcess": startProcess,
      "responseMode": responseMode,
      "licenseOK": licenseOK,
      "structure_access_info": structureAccessInfo,
      "records": records.toMap(),
      "endProcess": endProcess,
      "processingTime": processingTime,
      "Auftrag": auftrag,
      "errorMsg": errorMsg
    };
  }

  T convertTo<T>(T Function(Map) fromJson) => fromJson(auftrag);
}
