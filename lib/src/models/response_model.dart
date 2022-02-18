part of flutter_profacto_sdk.models;

class ProfactoResponse {
  ProfactoResponse({
    required this.error,
    required this.success,
    required this.startProcess,
    required this.responseMode,
    required this.licenseOK,
    required this.structureAccessInfo,
    required this.data,
    required this.records,
    required this.endProcess,
    required this.processingTime,
    required this.errorMsg,
  });
  late final String error;
  late final bool success;
  late final int startProcess;
  late final String responseMode;
  late final bool licenseOK;
  late final List<String> structureAccessInfo;
  late final Map<String, dynamic> data;
  late final ResponseRecords records;
  late final int endProcess;
  late final int processingTime;
  late final String errorMsg;

  ProfactoResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    success = json['success'];
    startProcess = json['startProcess'];
    responseMode = json['responseMode'];
    licenseOK = json['licenseOK'];
    structureAccessInfo =
        List.castFrom<dynamic, String>(json['structure_access_info']);
    data = json;
    records = ResponseRecords.fromJson(json['records']);
    endProcess = json['endProcess'];
    processingTime = json['processingTime'];
    errorMsg = json['errorMsg'];
  }

  T convertTo<T>(T Function(Map) fromJson) => fromJson(data);
}

class ProfactoPutResponse {
  ProfactoPutResponse({
    required this.error,
    required this.success,
    required this.startProcess,
    required this.responseMode,
    required this.licenseOK,
    required this.endProcess,
    required this.wasUpdate,
    required this.data,
    required this.processingTime,
    required this.errorMsg,
  });
  late final String error;
  late final bool success;
  late final int startProcess;
  late final String responseMode;
  late final bool licenseOK;
  late final bool wasUpdate;
  late final Map<String, dynamic> data;
  late final int endProcess;
  late final int processingTime;
  late final String errorMsg;

  ProfactoPutResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    success = json['success'];
    startProcess = json['startProcess'];
    responseMode = json['responseMode'];
    licenseOK = json['licenseOK'];
    wasUpdate = json['wasUpdate'];
    data = json;
    endProcess = json['endProcess'];
    processingTime = json['processingTime'];
    errorMsg = json['errorMsg'];
  }

  T convertTo<T>(T Function(Map) fromJson) => fromJson(data);
}
