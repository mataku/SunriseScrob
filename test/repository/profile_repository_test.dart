import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/endpoint/user_get_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/profile/user_get_info_api_response.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/profile_repository.dart';
import 'package:sunrisescrob/store/kv_store.dart';

import '../fixture.dart';
import 'profile_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, DioException, KVStore])
void main() {
  late app_mock.MockLastFmApiService apiService;
  late app_mock.MockDioException dioException;
  late app_mock.MockKVStore kvStore;
  late ProviderContainer providerContainer;

  const username = 'sunsetscrob';

  group('getUserInfo', () {
    setUp(() async {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      kvStore = app_mock.MockKVStore();
      when(kvStore.getStringValue(KVStoreKey.username)).thenAnswer((_) async {
        return username;
      });
      providerContainer = ProviderContainer(
        overrides: [
          lastFmApiServiceProvider.overrideWithValue(apiService),
          kvStoreProvider.overrideWithValue(kvStore),
        ],
      );
    });

    test('request succeeded', () async {
      final jsonMap = fixture('user_get_info.json');
      final userInfo = UserGetInfoApiResponse.fromJson(json.decode(jsonMap));
      when(apiService.request(any)).thenAnswer((_) async => userInfo);
      final repo = providerContainer.read(profileRepositoryProvider);
      final result = await repo.getUserInfo();
      expect(result is Success, true);
      expect(result.getOrNull()!.name, 'matakucom');

      verify(kvStore.getStringValue(KVStoreKey.username)).called(1);

      verify(
        apiService.request(
          UserGetInfoEndpoint(
            params: {'user': username},
          ),
        ),
      ).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = providerContainer.read(profileRepositoryProvider);
      final result = await repo.getUserInfo();
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
