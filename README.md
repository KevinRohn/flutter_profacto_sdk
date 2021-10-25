# profacto Flutter SDK (Unofficial)

The 'flutter_profacto_sdk' is an unofficial SDK for the profacto API.
It can be used to build flutter applications with profacto to improve business processes.

See the [profacto API documentation](https://conf.extragroup.de/pages/viewpage.action?pageId=25297229) for more information.

Please note:
The name convention of the profacto database fields are mixed in german and english.
So the naming of some variables have been adopted from the database structure... .

## Alpha version

This library is actively developed alongside production apps.

Having trouble adapting to the latest API? Please open an issue.

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
      ref: main
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


Get project data:
```dart

Projects projects = Projects(client);
projects.setProjectsToken('<token>');

projects.getProjectData(
    table: ProjectTable.Auftrag,
    fields: 'AuftragsNr,Bauvorhaben',
    query: 'AuftragsNr=06184');
  
```

## Additional information

- [profacto database structure](http://profacto.extragroup.biz/Service/profacto%20Structure%20Export/profacto.xml)


### Tokens

## Reference

