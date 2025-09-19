import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/model/key.dart';

part 'http_provider.g.dart';

final _options = BaseOptions(
  baseUrl: "https://ws.audioscrobbler.com",
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
  queryParameters: {'format': 'json'},
  headers: {'charset': 'utf-8'},
);

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(_options);
  dio.interceptors.add(const AuthInterceptor());
  if (kDebugMode) {
    dio.interceptors.add(const DebugLogInterceptor());
  }
  return dio;
}

class AuthInterceptor extends Interceptor {
  const AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({"api_key": Env.apiKey});
    super.onRequest(options, handler);
  }
}

class DebugLogInterceptor extends Interceptor {
  const DebugLogInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('####### State App Request Log #######');
    debugPrint('onRequest ---> ##### ${options.method} ${options.path}');
    debugPrint('onRequest ---> Full URL: ${options.uri}');
    debugPrint('onRequest ---> Headers: ${options.headers}');
    debugPrint('onRequest ---> Query Parameters: ${options.queryParameters}');
    debugPrint('onRequest ---> Request Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('######## State App Response Log ########');
    debugPrint(
      'onResponse <--- ${response.statusCode} ${response.requestOptions.path}',
    );
    debugPrint('onResponse <--- Headers: ${response.headers}');
    debugPrint('onResponse <--- Response Data: ${response.data}');
    super.onResponse(response, handler);
  }
}
