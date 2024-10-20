import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/endpoint/user_top_albums_endpoint.dart';
import 'package:sunrisescrob/api/endpoint/user_top_artists_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/user/top_albums_api_response.dart';
import 'package:sunrisescrob/api/response/user/top_artists_api_response.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/user_repository.dart';
import 'package:sunrisescrob/store/kv_store.dart';

import '../fixture.dart';
import 'user_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, DioException, KVStore])
void main() {
  late app_mock.MockLastFmApiService apiService;
  late app_mock.MockDioException dioException;
  late app_mock.MockKVStore kvStore;
  late ProviderContainer providerContainer;
  group('getTopAlbums', () {
    setUp(() async {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      kvStore = app_mock.MockKVStore();
      when(kvStore.getStringValue(KVStoreKey.username)).thenAnswer((_) async {
        return 'sunsetscrob';
      });
      providerContainer = ProviderContainer(
        overrides: [
          lastFmApiServiceProvider.overrideWithValue(apiService),
          kvStoreProvider.overrideWithValue(kvStore),
        ],
      );
    });

    test('request succeeded', () async {
      final response = fixture("user_top_albums.json");
      final albums = TopAlbumsApiResponse.fromJson(json.decode(response));
      when(apiService.request(any)).thenAnswer((_) async => albums);
      final repo = providerContainer.read(userRepositoryProvider);
      final result = await repo.getTopAlbums(1);
      expect(result is Success, true);
      expect(result.getOrNull()!.isNotEmpty, true);
      verify(kvStore.getStringValue(KVStoreKey.username)).called(1);
      verify(apiService.request(UserTopAlbumsEndpoint(
        params: {
          'page': '1',
          'user': 'sunsetscrob',
        },
      ),),).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = providerContainer.read(userRepositoryProvider);
      final result = await repo.getTopAlbums(1);
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });

  group('getTopArtists', () {
    setUp(() async {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      kvStore = app_mock.MockKVStore();
      when(kvStore.getStringValue(KVStoreKey.username)).thenAnswer((_) async {
        return 'sunsetscrob';
      });
      providerContainer = ProviderContainer(
        overrides: [
          lastFmApiServiceProvider.overrideWithValue(apiService),
          kvStoreProvider.overrideWithValue(kvStore),
        ],
      );
    });

    test('request succeeded', () async {
      final response = fixture("user_top_artists.json");
      final albums = TopArtistsApiResponse.fromJson(json.decode(response));
      when(apiService.request(any)).thenAnswer((_) async => albums);
      final repo = providerContainer.read(userRepositoryProvider);
      final result = await repo.getTopArtists(1);
      expect(result is Success, true);
      expect(result.getOrNull()!.isNotEmpty, true);
      verify(kvStore.getStringValue(KVStoreKey.username)).called(1);
      verify(apiService.request(UserTopArtistsEndpoint(
        params: {
          'page': '1',
          'user': 'sunsetscrob',
        },
      ),),).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = providerContainer.read(userRepositoryProvider);

      final result = await repo.getTopArtists(1);
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
