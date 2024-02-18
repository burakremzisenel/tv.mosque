import 'package:dio/browser.dart' as browser;
import 'package:dio/dio.dart';
HttpClientAdapter getAdapter() {
  var adapter = browser.BrowserHttpClientAdapter();
  adapter.withCredentials = true;
  return adapter;
}