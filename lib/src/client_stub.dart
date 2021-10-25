import 'client_base.dart';

ClientBase createClient({required String endPoint, required bool selfSigned}) =>
    throw UnsupportedError(
        'Cannot create a client without dart:html or dart:io.');
