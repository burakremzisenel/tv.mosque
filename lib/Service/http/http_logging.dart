import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR[${err.message}]');
    super.onError(err, handler);
  }
}