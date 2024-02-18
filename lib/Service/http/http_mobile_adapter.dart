import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
HttpClientAdapter getAdapter() {
  return IOHttpClientAdapter(
    createHttpClient: () {
      // Don't trust any certificate just because their root cert is trusted.
      final HttpClient client =
      HttpClient(context: SecurityContext(withTrustedRoots: false));
      // You can test the intermediate / root cert here. We just ignore it.
      client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
      return client;
    },
  );
}