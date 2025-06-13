import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
class AppError with _$AppError implements Exception {
  // 401
  const factory AppError.unauthorized() = _Unauthorized;
  const factory AppError.noInternetConnection() = _NoInternetConnection;
  const factory AppError.unexpected() = _Unexpected;
  const factory AppError.serverError() = _ServerError;
  const factory AppError.clientError() = _ClientError;

  // TODO: type
  static AppError getApiError(dynamic error) {
    if (error is Exception) {
      if (error is DioException) {
        // parse http error
        AppError appError;
        switch (error.type) {
          case DioExceptionType.connectionError ||
                DioExceptionType.connectionTimeout:
            appError = const AppError.serverError();
            break;
          case DioExceptionType.badResponse:
            final response = error.response;
            if (response?.statusCode == 401) {
              appError = const AppError.unauthorized();
            } else {
              appError = const AppError.clientError();
            }
            break;
          default:
            appError = const AppError.unexpected();
        }

        return appError;
      }
      return const AppError.noInternetConnection();
    } else {
      return const AppError.unexpected();
    }
  }
}
