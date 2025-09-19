import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/http_provider.dart';

part 'last_fm_api_service.g.dart';

@Riverpod(keepAlive: true, dependencies: [dio])
LastFmApiService lastFmApiService(Ref ref) {
  return _LastFmApiServiceImpl(dio: ref.read(dioProvider));
}

abstract class LastFmApiService {
  Future<T> request<T>(Endpoint<T> endpoint);
}

class _LastFmApiServiceImpl extends LastFmApiService {
  final Dio _dio;

  _LastFmApiServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<T> request<T>(Endpoint<T> endpoint) async {
    final result = switch (endpoint.requestType) {
      RequestType.get => _get(endpoint),
      RequestType.post => _post(endpoint),
    };

    return result;
  }

  Future<T> _get<T>(Endpoint<T> endpoint) async {
    final response =
        await _dio.get(endpoint.path, queryParameters: endpoint.params);
    return endpoint.parseFromJson(response);
  }

  Future<T> _post<T>(Endpoint<T> endpoint) async {
    final response =
        await _dio.post(endpoint.path, queryParameters: endpoint.params);
    return endpoint.parseFromJson(response);
  }
}
