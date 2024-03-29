# profacto flutter SDK (unofficial)

The `flutter_profacto_sdk` is an unofficial SDK for the profacto API.
It can be used to build flutter applications with profacto to improve business processes.

See the [profacto API documentation](https://conf.extragroup.de/pages/viewpage.action?pageId=25297229) for more information.

**Please note:**
The name convention of the profacto database fields are mixed in german and english.
So the naming of some variables has been adopted from the database structure... .

## Alpha version

This library is actively developed alongside production apps.

Having trouble adapting to the latest SDK? Please open an issue.

**Please be fully prepared to deal with breaking changes.**

## Features

Retrieve and update data entries from the profacto database using the profacto API.

## Usage

The package is not published to [pub.dev](https://pub.dev) yet.

### Installation

To install the package from github add following information to the `pubspec.yaml` file:

```yml
dependencies:
  flutter_profacto_sdk:
    git:
      url: https://github.com/KevinRohn/flutter_profacto_sdk
      ref: master
```

Use `ref` to choose the branch or tag you want to use.

### Getting started

Initialize the SDK:

```dart
import 'package:flutter_profacto_sdk/flutter_profacto_sdk.dart';

ProfactoClient client = ProfactoClient();

client.setEndpoint('http://<server-url>:<server-port>/4DAction');
```

- replace `<server-url>` with the url of the profacto server
- replace `<server-port>` with the port of the profacto server


Get project data with specific query and with predefined fields:
```dart

Projects projects = Projects(client);
projects.setProjectsToken('<token>');

Future<ProfactoResponse> result = projects.getProjectData(
  table: ProjectTable.Auftrag,
  fields: 'AuftragsNr',
  limit: 2,
  query: ''
);

result.then((response) {
  print(response.data['Auftrag']);
}).catchError((error) {
  print(error.response);
});
```

example response:
```JSON
{
  "error": "",
  "success": true,
  "startProcess": 434462492,
  "responseMode": "JSON",
  "licenseOK": true,
  "structure_access_info": [],
  "Auftrag": [
    {
      "AuftragsNr": "05104B"
    },
    {
      "AuftragsNr": "06127"
    }
  ],
  "records": {
    "total_in_query": 17750,
    "offset": 0,
    "limit": 2,
    "total_in_page": 2
  },
  "endProcess": 434462746,
  "processingTime": 254,
  "errorMsg": ""
}
```

Get all projects with predefined fields:
```dart

Projects projects = Projects(client);
projects.setProjectsToken('<token>');

Future<ProfactoResponse> result = projects.getProjectData(
  table: ProjectTable.Auftrag,
  fields: 'AuftragsNr,Bauvorhaben'
);

result.then((response) {
  print(response.data['Auftrag']);
}).catchError((error) {
  print(error.response);
});
```



-replace `<token>` with a valid token, which has `"Projekte"` rights.

## Additional information

- [profacto database structure](http://profacto.extragroup.biz/Service/profacto%20Structure%20Export/profacto.xml)


### Tokens

There is no master token available. Tokens are bound to specific database tables.
profacto provides a list for the category of the tokens. 

## Reference

### API - Projekte

- Requires API-token `"Projekte"`
- Documentation link profacto [API - Projekte](https://conf.extragroup.de/display/handbuch/API+-+Projekte)

| API call                      |       State        | Description |
| :---------------------------- | :----------------: | :---------- |
| 'api_get'                     | :white_check_mark: |             |
| 'api_get_qr'                  |        :x:         |             |
| 'api_put_project'             |        :x:         |             |
| 'api_put_projectpos'          |        :x:         |             |
| 'api_getposdelta'             |        :x:         |             |
| 'api_get_project_doccopylist' |        :x:         |             |
| 'api_get_project_filelist'    |        :x:         |             |

### API - Bestellung

- Requires API-token `"Bestellung"`
- Documentation link profacto ['API - Bestellung'](https://conf.extragroup.de/display/handbuch/API+-+Bestellung)

| API call             |       State        | Description |
| :------------------- | :----------------: | :---------- |
| 'api_get'            | :white_check_mark: |             |
| 'api_put_bestellung' |        :x:         |             |
| 'api_put_bestellpos' | :white_check_mark: |             |

### ['API - Dateien'](https://conf.extragroup.de/display/handbuch/API+-+Dateien)
### ['API - Kunden'](https://conf.extragroup.de/display/handbuch/API+-+Kunden)
### ['API - Produktion'](https://conf.extragroup.de/display/handbuch/API+-+Produktion)
### ['API - Allgemein'](https://conf.extragroup.de/display/handbuch/API+-+Allgemein)
### ['API - Artikel'](https://conf.extragroup.de/display/handbuch/API+-+Artikel)
### ['API - Lieferanten'](https://conf.extragroup.de/display/handbuch/API+-+Lieferanten)
### ['API - Lager'](https://conf.extragroup.de/display/handbuch/API+-+Lager)
### ['API - Zeiterfassung'](https://conf.extragroup.de/display/handbuch/API+-+Zeiterfassung)
### ['API - Aktivitäten'](https://conf.extragroup.de/pages/viewpage.action?pageId=105612059)
### ['API - Personal'](https://conf.extragroup.de/display/handbuch/API+-+Personal)
### ['API - Kontakte'](https://conf.extragroup.de/display/handbuch/API+-+Kontakte)
### ['API - Integration'](https://conf.extragroup.de/display/handbuch/API+-+Integration)
### ['API - Buchhaltung'](https://conf.extragroup.de/display/handbuch/API+-+Buchhaltung)
### ['API - Public'](https://conf.extragroup.de/display/handbuch/API+-+Public)

