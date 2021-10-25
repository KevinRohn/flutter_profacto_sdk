import 'client_base.dart';

ClientBase createClient(
        {required String endPoint,
        required bool selfSigned,
        required String token}) =>
    throw UnsupportedError(
        'Cannot create a client without dart:html or dart:io.');
